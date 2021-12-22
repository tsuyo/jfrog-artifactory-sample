package dev.tsuyo.hello;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.Test;

import kong.unirest.HttpResponse;
import kong.unirest.Unirest;

public class HelloWorldTest {

    private HelloWorld app = new HelloWorld();

    @Test
    public void getHello() {
        app.start(8080);
        HttpResponse<String> response = Unirest.get("http://localhost:8080/").asString();
        assertThat(response.getStatus()).isEqualTo(200);
        app.stop();
    }
}