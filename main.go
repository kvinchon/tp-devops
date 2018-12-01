package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"wsf/revisions/devops/handler"
)

func main() {

	// connection := os.Getenv("DATABASE_URL")

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	myHandler := handler.NewHandler()

	server := &http.Server{
		Addr:    ":" + port,
		Handler: myHandler,
		// ReadTimeout:  10 * time.Second,
		// WriteTimeout: 10 * time.Second,
	}

	fmt.Println("Everything is OK")
	fmt.Println("Server is running at", port)

	log.Fatal(server.ListenAndServe())
}
