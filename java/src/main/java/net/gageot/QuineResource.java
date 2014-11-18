package net.gageot;

import com.squareup.okhttp.*;
import net.codestory.http.annotations.Post;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.regex.Pattern;

import static java.util.stream.Collectors.toList;

public class QuineResource {
    private final String nextUrl;

    public QuineResource() {
        this.nextUrl = "next:8080";
    }

    public QuineResource(String nextUrl) {
        this.nextUrl = nextUrl;
    }

    @Post("/run/:language")
    public byte[] run(String language, byte[] script) throws IOException, InterruptedException {
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
        byte[] result = runScript(script, command);
        System.out.println(result.length);

        // Call next in chain
        if (index == (steps.size() - 1)) {
            System.out.println("DONE");
            return result;
        }

        System.out.println("Sending query to " + nextUrl);
        Request request = new Request.Builder()
                .url("http://" + nextUrl + "/run/" + steps.get(index + 1))
                .post(RequestBody.create(MediaType.parse("application/octet-stream"), result))
                .build();

        Response response = new OkHttpClient().newCall(request).execute();
        return response.body().bytes();
    }

    protected byte[] runScript(byte[] script, String command) throws IOException, InterruptedException {
        File root = new File("/quine-relay");

        // Find input and output
        List<String> files = Pattern
                .compile(" ")
                .splitAsStream(command)
                .filter(part -> part.toLowerCase().contains("qr."))
                .map(part -> part.substring(part.toLowerCase().indexOf("qr.")))
                .collect(toList());

        String from = files.get(0);
        if ("QR.r.f".equals(from)) {
            from = "QR.r";
        }
        String to = files.get(files.size() - 1);

        // Write input
        Files.write(new File(root, from).toPath(), script);

        // Run script
        new ProcessBuilder("bash", "-c", command)
                .directory(root)
                .start()
                .waitFor();

        return Files.readAllBytes(new File(root, to).toPath());
    }
}
