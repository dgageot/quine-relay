package net.gageot;

import net.codestory.http.WebServer;
import net.codestory.http.annotations.Post;
import org.apache.commons.io.FileUtils;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class Server {
    public static void main(String[] args) throws Exception {
        new WebServer().configure(routes -> routes.add(QuineResource.class)).start();
    }

    public static class QuineResource {
        @Post("/")
        public String run(String script) throws IOException, InterruptedException {
            String language = System.getenv("LANGUAGE");
            boolean isTerminal = System.getenv("NEXT_NAME") == null;
            File root = new File("/quine-relay");

            List<String> steps = Files.readAllLines(Paths.get("/quine-relay/steps"));
            List<String> commands = Files.readAllLines(Paths.get("/quine-relay/commands.sh"));

            for (int index = 0; index < steps.size(); index++) {
                String step = steps.get(index);

                if (language.equals(step)) {
                    String command = commands.get(index);

                    List<String> files = Stream.of(command.split(" "))
                            .filter(part -> part.toLowerCase().contains("qr."))
                            .map(part -> part.substring(part.toLowerCase().indexOf("qr.")))
                            .collect(Collectors.toList());

                    String from = files.get(0);
                    String to = files.get(files.size() - 1);

                    System.out.println("========================================================");
                    System.out.println(step);
                    System.out.println(command);

                    // Write input
                    FileUtils.write(new File(root, from), script);

                    // Run script
                    Process processCompile = new ProcessBuilder("bash", "-c", command)
                            .directory(root)
                            .start();
                    processCompile.waitFor();

                    if (isTerminal) {
                        System.out.println("DONE");
                        return FileUtils.readFileToString(new File(root, to));
                    }

                    // Call next in chain
                    Process processNext = new ProcessBuilder("curl", "--data-binary", "@" + to, "http://next:8080/")
                            .redirectOutput(new File(root, "next"))
                            .directory(root)
                            .start();
                    processNext.waitFor();

                    return FileUtils.readFileToString(new File(root, "next"));
                }
            }

            throw new IllegalArgumentException("Unknown language " + language);
        }
    }
}
