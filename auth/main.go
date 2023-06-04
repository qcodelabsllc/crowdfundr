package main

import (
	"github.com/joho/godotenv"
	"github.com/qcodelabsllc/crowdfundr/auth/config"
	"log"
)

func main() {
	// load config from env file
	if err := godotenv.Load(); err != nil {
		log.Fatal("Error loading .env file")
	}

	// initialize database connection
	config.InitDatabase()

	// start gRPC server
	config.StartServer()
}
