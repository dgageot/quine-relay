package main

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
	"os/exec"
	"strings"

	"github.com/gorilla/mux"
)

type Step struct {
	Language string
	Next     string
	Command  string
	From     string
	To       string
}

func RunHandler(r *http.Request) ([]byte, error) {
	vars := mux.Vars(r)
	language := vars["language"]

	// Read POST query body
	script, err := ioutil.ReadAll(r.Body)
	if err != nil {
		return nil, errors.New("Unable to read query body: " + err.Error())
	}

	// Read all steps
	var steps []Step
	err = readJson("steps.json", &steps)
	if err != nil {
		return nil, errors.New("Unable to read steps.json: " + err.Error())
	}

	// Find language position in chain
	index := languagePosition(steps, language)
	if index == -1 {
		return nil, errors.New("Unknown language: " + language)
	}
	step := steps[index]

	// Run script
	result, err := runScript(script, step)
	if err != nil {
		return nil, errors.New("Unable to run script: " + err.Error())
	}

	// Last in chain?
	if index == (len(steps) - 1) {
		return result, nil
	}

	// Call next in chain
	resp, err := http.Post(("http://localhost:8080/run/" + step.Next), "application/octet-stream", bytes.NewBuffer(result))
	if err != nil {
		return nil, errors.New("Unable to call next one in chain: " + err.Error())
	}

	defer resp.Body.Close()
	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return nil, errors.New("Unable to read response from next in chain: " + err.Error())
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
	if err := cmd.Run(); err != nil {
		return nil, err
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

// readJson reads a json file.
func readJson(path string, value interface{}) error {
	file, err := ioutil.ReadFile(path)
	if err != nil {
		return err
	}

	return json.Unmarshal(file, &value)
}

// readLines returns the lines of a given file.
func readLines(path string) ([]string, error) {
	content, err := ioutil.ReadFile(path)
	if err != nil {
		return nil, err
	}

	lines := strings.Split(string(content), "\n")
	return lines, nil
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
