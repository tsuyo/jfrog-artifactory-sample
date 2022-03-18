package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"

	"rsc.io/quote"
)

func main() {
	// register hello function to handle all requests
	mux := http.NewServeMux()
	mux.HandleFunc("/", hello)

	// use PORT environment variable, or default to 8080
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	// start the web server on port and accept requests
	log.Printf("Server listening on port %s", port)
	log.Fatal(http.ListenAndServe(":"+port, mux))
}

// hello responds to the request with a plain-text "Hello, world" message.
func hello(w http.ResponseWriter, r *http.Request) {
	log.Printf("Serving request: %s", r.URL.Path)
	log.Println(quote.Hello())

	welcome := "Hello from Go!"
	host, _ := os.Hostname()
	message := os.Getenv("MESSAGE")
	version := os.Getenv("VERSION")
	if message == "" {
		message = "Hello, world!"
	}
	if version == "" {
		version = "1.0.0"
	}

	rmap := map[string]string{
		"Welcome":  welcome,
		"Message":  message,
		"Version":  version,
		"Hostname": host,
	}
	rbytes, _ := json.Marshal(rmap)
	fmt.Fprintln(w, string(rbytes))
}
