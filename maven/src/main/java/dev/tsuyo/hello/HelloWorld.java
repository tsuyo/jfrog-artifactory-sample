package dev.tsuyo.hello;

import java.io.IOException;
import java.io.InputStream;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Properties;

import io.javalin.Javalin;

public class HelloWorld {
    private Javalin app;

    public HelloWorld() {
        app = Javalin.create();
        app.get("/", ctx -> ctx.json(new HelloInfo()));
    }

    public void start(int port) {
        app.start(port);
    }

    public void stop() {
        app.stop();
    }

    public static void main(String[] args) {
        new HelloWorld().start(8080);
    }
}

class HelloInfo {
    private String version;
    private String message;
    private String hostname;

    public HelloInfo() {
        setVersion();
        setMessage();
        setHostname();
    }

    public void setVersion() {
        try (InputStream input = HelloWorld.class.getClassLoader().getResourceAsStream("application.properties")) {
            if (input == null) {
                System.out.println("Sorry, unable to find application.properties");
                return;
            }

            Properties prop = new Properties();
            prop.load(input);
            version = prop.getProperty("hello.version");
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }

    public void setMessage() {
        message = System.getenv("MESSAGE");
    }

    public void setHostname() {
        try {
            hostname = InetAddress.getLocalHost().getHostName();
        } catch (UnknownHostException e) {
            e.printStackTrace();
        }
    }

    public String getVersion() {
        return version;
    }

    public String getMessage() {
        return message;
    }

    public String getHostname() {
        return hostname;
    }

}
