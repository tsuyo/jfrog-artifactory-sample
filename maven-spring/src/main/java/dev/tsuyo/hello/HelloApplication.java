package dev.tsuyo.hello;

import java.net.InetAddress;
import java.net.UnknownHostException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Component
class HelloInfo {
  @Value("${hello.version:0.0.1}")
  private String version;
  private String message;
  private String hostname;

  public HelloInfo() {
    message = System.getenv("MESSAGE");
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

@SpringBootApplication
@RestController
public class HelloApplication {
  @Autowired
  private HelloInfo hi;

  public static void main(String[] args) {
    SpringApplication.run(HelloApplication.class, args);
  }

  @RequestMapping("/")
  public HelloInfo index() {
    return hi;
  }

}
