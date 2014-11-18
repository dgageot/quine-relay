package net.gageot;

import com.squareup.okhttp.*;
import net.codestory.http.annotations.Post;
import org.apache.commons.io.FileUtils;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.stream.Stream;

import static java.util.stream.Collectors.toList;

public class QuineResource {
    private final String nextUrl;

    public QuineResource() {
        String nextHost = System.getenv("NEXT_PORT_8080_TCP_ADDR");
        String nextPort = System.getenv("DB_PORT_5432_TCP_PORT");

        this.nextUrl = "http://" + nextHost + ":" + nextPort;
    }

    public QuineResource(String nextUrl) {
        this.nextUrl = nextUrl;
    }

    @Post("/run/:language")
    public String run(String language, String script) throws IOException, InterruptedException {
        List<String> steps = Files.readAllLines(Paths.get("steps"));

        int index = steps.indexOf(language);
        if (index == -1) {
            throw new IllegalArgumentException("Unknown language " + language);
        }

        List<String> commands = Files.readAllLines(Paths.get("commands.sh"));
        String command = commands.get(index);

        System.out.println("========================================================");
        System.out.println(language);
        System.out.println(command);

        // Execute language
        String result = runScript(script, command);
        System.out.println(result.length());

        // Call next in chain
        if (index == (steps.size() - 1)) {
            System.out.println("DONE");
            return result;
        }

        System.out.println("Sending query to " + nextUrl);
        Request request = new Request.Builder()
                .url("http://" + nextUrl + "/run/" + steps.get(index + 1))
                .post(RequestBody.create(MediaType.parse("text/plain"), result))
                .build();

        Response response = new OkHttpClient().newCall(request).execute();
        return response.body().string();
    }

    protected String runScript(String script, String command) throws IOException, InterruptedException {
        File root = new File("/quine-relay");

        // Find input and output
        List<String> files = Stream.of(command.split(" "))
                .filter(part -> part.toLowerCase().contains("qr."))
                .map(part -> part.substring(part.toLowerCase().indexOf("qr.")))
                .collect(toList());

        String from = files.get(0);
        String to = files.get(files.size() - 1);

        // Write input
        FileUtils.write(new File(root, from), script);

        // Run script
        new ProcessBuilder("bash", "-c", command)
                .directory(root)
                .start()
                .waitFor();

        return FileUtils.readFileToString(new File(root, to));
    }
}
