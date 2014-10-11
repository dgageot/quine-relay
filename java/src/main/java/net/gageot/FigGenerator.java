package net.gageot;

import java.io.*;
import java.nio.file.*;
import java.util.*;

public class FigGenerator {
	public static void main(String[] args) throws IOException {
		List<String> steps = Files.readAllLines(Paths.get("/Users/dgageot/src/docker/quine-relay/list"));

		int count = steps.size();
		for (int index = count - 1; index >= 0; index--) {
			String step = steps.get(index);

			System.out.println(step + ":");
			System.out.println("  image: dgageot/quine-relay");
			System.out.println("  mem_limit: 32M");
			System.out.println("  environment:");
			System.out.println("    - LANGUAGE=" + step);

			if (index != (count - 1)) {
				System.out.println("  links:");
				System.out.println("    - " + steps.get(index + 1) + ":next");
			}

			if (index == 0) {
				System.out.println("  ports:");
				System.out.println("    - \"8080:8080\"");
			}

			System.out.println();
		}
	}
}
