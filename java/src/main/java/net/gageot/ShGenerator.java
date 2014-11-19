package net.gageot;

import org.apache.commons.io.FileUtils;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import static java.util.stream.Collectors.joining;

public class ShGenerator {
    public static void main(String[] args) throws IOException {
        List<String> steps = Files.readAllLines(Paths.get("steps"));

        StringBuilder script = new StringBuilder();

        script.append("#!/bin/bash");
        script.append("\n\n");
        script.append("docker rm -f " + steps.stream().map(step -> "q-" + step).collect(joining(" ")));
        script.append("\n\n");
        script.append("set -e");
        script.append("\n\n");

        int count = steps.size();
        for (int index = count - 1; index >= 0; index--) {
            String step = steps.get(index);

            List<String> commands = new ArrayList<>();
            commands.add("docker");
            commands.add("run");
            commands.add("-d");
            commands.add("--memory=1G");
            commands.add("--name=q-" + step);
            commands.add("-e");
            commands.add("LANGUAGE=" + step);
            if (index == 0) {
                commands.add("-p 8080:8080");
            }
            if (index != count - 1) {
                commands.add("--link=q-" + steps.get(index + 1) + ":next");
            }
            commands.add("dgageot/quine-relay");

            script.append(String.join(" ", commands));
            script.append("\n");
        }

        script.append("./logs.sh " + steps.stream().map(step -> "q-" + step).collect(joining(" ")));

        System.out.println(script);
        FileUtils.write(new File("../server.sh"), script);
        new File("../server.sh").setExecutable(true);
    }
}
