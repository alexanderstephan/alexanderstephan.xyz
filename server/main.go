package main

import (
	"embed"
	"io/fs"
	"log"
	"net/http"
)

//go:embed static
var static embed.FS

func main() {
	f, err := fs.Sub(static, "static")
	if err != nil {
		log.Fatal(err)
	}
	http.Handle("/", http.FileServer(http.FS(f)))

	log.Println("Starting server...")
	if err := http.ListenAndServe(":80", nil); err != nil {
		log.Fatal(err)
	}
}
