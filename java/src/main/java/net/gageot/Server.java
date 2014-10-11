package net.gageot;

import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.regex.*;

import net.codestory.http.*;
import net.codestory.http.annotations.*;

import org.apache.commons.io.*;

public class Server {
	public static void main(String[] args) throws Exception {
		new WebServer(routes -> routes.add(QuineResource.class)).start();
	}

	public static class QuineResource {
		@Post("/")
		public String run(String script) throws IOException, InterruptedException {
			String language = System.getenv("LANGUAGE");
			boolean isTerminal = System.getenv("NEXT_NAME") == null;
			File root = new File("/quine-relay");

			List<String> steps = Files.readAllLines(Paths.get("/quine-relay/list"));
			List<String> commands = Files.readAllLines(Paths.get("/quine-relay/old.sh"));

			for (int index = 0; index < steps.size(); index++) {
				String step = steps.get(index);

				if (language.equals(step)) {
					String command = commands.get(index);
					System.out.println(command);

					Matcher matcher = Pattern.compile(".*([qQ][rR]\\..*?) .*> ([qQ][rR]\\..*)").matcher(command);
					if (!matcher.find()) {
						throw new IllegalStateException("Invalid command " + command);
					}

					String from = matcher.group(1);
					String to = matcher.group(2);

					// Write input
					FileUtils.write(new File(root, from), script);

					// Run script
					Process processCompile = new ProcessBuilder("bash", "-c", command)
							.directory(root)
							.start();
					processCompile.waitFor();

					if (isTerminal) {
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
