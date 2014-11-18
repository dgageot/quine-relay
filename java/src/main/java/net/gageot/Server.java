package net.gageot;

import net.codestory.http.WebServer;

public class Server {
    public static void main(String[] args) {
        new WebServer().configure(routes -> routes.add(new QuineResource())).start();
    }
}
