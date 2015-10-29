package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
	"os/exec"

	"github.com/gorilla/mux"
)

// Step describes each step in the quine.
type Step struct {
	Language string
	Next     string
	Command  string
	From     string
	To       string
}

// RunHandler is the main entry point for the http server.
func RunHandler(r *http.Request) ([]byte, error) {
	vars := mux.Vars(r)
	language := vars["language"]

	// Read POST query body
	script, err := ioutil.ReadAll(r.Body)
	if err != nil {
		return nil, fmt.Errorf("Unable to read query body: %s", err)
	}

	// Read all steps
	var steps []Step
	err = readJSON("steps.json", &steps)
	if err != nil {
		return nil, fmt.Errorf("Unable to read steps.json: %s", err)
	}

	// Find language position in chain
	index := languagePosition(steps, language)
	if index == -1 {
		return nil, fmt.Errorf("Unknown language: %s", language)
	}
	step := steps[index]

	// Run script
	result, err := runScript(script, step)
	if err != nil {
		return nil, fmt.Errorf("Unable to run script: %s", err)
	}

	// Last in chain?
	if index == (len(steps) - 1) {
		return result, nil
	}

	// Call next in chain
	resp, err := http.Post(("http://next:8080/run/" + step.Next), "application/octet-stream", bytes.NewBuffer(result))
	if err != nil {
		return nil, fmt.Errorf("Unable to call next one in chain: %s", err)
	}

	defer resp.Body.Close()
	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return nil, fmt.Errorf("Unable to read response from next in chain: %s", err)
	}

	return body, nil
}

func runScript(script []byte, step Step) ([]byte, error) {
	fmt.Println(step.Language)

	// Write input
	err := ioutil.WriteFile("/tmp/quine/"+step.From, script, os.ModePerm)
	if err != nil {
		return nil, err
	}

	cmd := exec.Command("bash", "-c", step.Command)
	cmd.Dir = "/tmp/quine/"
	if output, err := cmd.CombinedOutput(); err != nil {
		return nil, fmt.Errorf("Failed to run command: %s %s", string(output), err)
	}

	// Read output
	return ioutil.ReadFile("/tmp/quine/" + step.To)
}

func main() {
	mux := mux.NewRouter()
	mux.HandleFunc("/run/{language}", withError(RunHandler)).Methods("POST")
	http.ListenAndServe(":8080", mux)
}

func withError(handler func(*http.Request) ([]byte, error)) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		result, err := handler(r)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		w.Write(result)
	}
}

// readJSON reads a json file.
func readJSON(path string, value interface{}) error {
	file, err := ioutil.ReadFile(path)
	if err != nil {
		return err
	}

	return json.Unmarshal(file, &value)
}

// languagePosition returns the index of a given language in a steps array. -1 if not found.
func languagePosition(steps []Step, language string) int {
	for index, step := range steps {
		if language == step.Language {
			return index
		}
	}

	return -1
}
