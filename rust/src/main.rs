use gethostname::gethostname;
use std::env;
use std::io::Write;
use std::net::{TcpListener, TcpStream};
use std::thread;

fn handle_write(mut stream: TcpStream) {
    let welcome = "Hello from Rust!";
    let host = gethostname();
    let message = env::var("MESSAGE").unwrap_or("".to_string());
    let version = env::var("VERSION").unwrap_or("".to_string());

    let response_json = format!(
        concat!(
            "HTTP/1.1 200 OK\r\n",
            "Content-Type: application/json; charset=UTF-8\r\n\r\n",
            "{{",
            "\"Welcome\": \"{}\", ",
            "\"Message\": \"{}\", ",
            "\"Version\": \"{}\", ",
            "\"Hostname\": {:?}",
            "}}\r\n"
        ),
        welcome, message, version, host
    );

    // match stream.write(response) {
    match stream.write(response_json.as_bytes()) {
        Ok(_) => println!("Response sent"),
        Err(e) => println!("Failed sending response: {}", e),
    }
}

fn handle_client(stream: TcpStream) {
    handle_write(stream);
}

fn main() {
    let port = env::var("PORT").unwrap_or("8080".to_string());

    println!("Server listening on port {}", port);
    let listener = TcpListener::bind(format!("127.0.0.1:{}", port)).unwrap();

    for stream in listener.incoming() {
        match stream {
            Ok(stream) => {
                thread::spawn(|| handle_client(stream));
            }
            Err(e) => {
                println!("Unable to connect: {}", e);
            }
        }
    }
}
