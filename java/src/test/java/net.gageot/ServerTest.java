package net.gageot;

import com.squareup.okhttp.*;
import net.codestory.http.WebServer;
import org.junit.Test;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.LinkedList;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

public class ServerTest {
    @Test
    public void full_cycle() throws IOException {
        LinkedList<WebServer> servers = startServers();

        Request request = new Request.Builder()
                .url("http://localhost:" + servers.getLast().port() + "/run/ruby")
                .post(RequestBody.create(MediaType.parse("text/plain"), "script"))
                .build();

        Response response = new OkHttpClient().newCall(request).execute();
        String body = response.body().string();

        assertThat(body).isEqualTo("DONE");
    }

    private static LinkedList<WebServer> startServers() throws IOException {
        LinkedList<WebServer> servers = new LinkedList<>();

        int previousPort = -1;
        List<String> steps = Files.readAllLines(Paths.get("steps"));
        for (int i = steps.size() - 1; i >= 0; i--) {
            QuineResource quineResource = new QuineResource("localhost:" + previousPort) {
                @Override
                protected String runScript(String script, String command) throws IOException, InterruptedException {
                    return "DONE";
                }
            };

            WebServer server = new WebServer().configure(routes -> routes.add(quineResource)).startOnRandomPort();
            previousPort = server.port();

            servers.add(server);
        }

        return servers;
    }
}
