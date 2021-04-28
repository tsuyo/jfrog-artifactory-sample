package dev.tsuyo.hello;

import java.net.InetAddress;
import java.net.UnknownHostException;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

class HelloInfo {
  private String message;
  private String version;
  private String hostname;

  public void setMessage(String message) {
    this.message = message;
  }

  public void setVersion(String version) {
    this.version = version;
  }

  public void setHostname(String hostname) {
    this.hostname = hostname;
  }

  public String getMessage() {
    return message;
  }

  public String getVersion() {
    return version;
  }

  public String getHostname() {
    return hostname;
  }

}

@RestController
public class HelloController {

  @RequestMapping("/")
  public HelloInfo index() {
    HelloInfo hi = new HelloInfo();

    // message
    String message = System.getenv("MESSAGE");
    hi.setMessage(message);

    // version
    String version = System.getenv("VERSION");
    hi.setVersion(version);

    // hostname
    try {
      String hostname = InetAddress.getLocalHost().getHostName();
      hi.setHostname(hostname);
    } catch (UnknownHostException e) {
      e.printStackTrace();
    }
    return hi;
  }

}