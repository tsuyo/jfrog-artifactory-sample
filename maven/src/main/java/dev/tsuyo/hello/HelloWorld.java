package dev.tsuyo.hello;

import java.io.OutputStream;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;
import com.sun.net.httpserver.HttpServer;

public class HelloWorld {

    public void start(int port) {
        try {
            HttpServer server = HttpServer.create(new InetSocketAddress(port), 0);

            server.createContext("/", httpExchange -> {
                String welcome = "Hello from Java!";
                String message = System.getenv("MESSAGE");
                String version = System.getenv("VERSION");
                String hostname = InetAddress.getLocalHost().getHostName();

                Map<String, String> map = new HashMap<String, String>();
                map.put("Welcome", welcome);
                map.put("Message", message);
                map.put("Version", version);
                map.put("Hostname", hostname);
                String str = new Gson().toJson(map);

                byte response[] = str.getBytes("UTF-8");

                httpExchange.getResponseHeaders().add("Content-Type", "application/json; charset=UTF-8");
                httpExchange.sendResponseHeaders(200, response.length);

                OutputStream out = httpExchange.getResponseBody();
                out.write(response);
                out.close();
            });

            server.start();
        } catch (Throwable tr) {
            tr.printStackTrace();
        }
    }

    public static void main(String[] args) {
        int port = 8080;
        System.out.printf("Server listening on port %s\n", port);
        new HelloWorld().start(port);
    }
}
