# Makefile for Hugo and Go server

# Variables
HUGO=hugo
HUGO_DIR=.
SERVER_DIR=server

.PHONY: help hugo-build hugo-serve server-build server-run clean

help:
	@echo "Available targets:"
	@echo "  hugo-build   - Build the Hugo static site (output in ./public)"
	@echo "  hugo-serve   - Serve the Hugo site locally with live reload"
	@echo "  server-build - Build the Go server binary (output: server/site)"
	@echo "  server-run   - Run the Go server (serves ./server/static)"
	@echo "  clean        - Remove Hugo and server build outputs"

hugo-build:
	cd $(HUGO_DIR) && $(HUGO) --minify --baseURL="https://alexanderstephan.xyz/" -D

hugo-serve:
	cd $(HUGO_DIR) && $(HUGO) server

server-build:
	rm -rf server/static
	cp -r public server/static
	cd $(SERVER_DIR) && go build -o site main.go

server-run:
	cd $(SERVER_DIR) && ./site

clean:
	rm -rf public
	rm -f $(SERVER_DIR)/site
