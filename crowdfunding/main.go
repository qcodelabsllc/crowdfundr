package main

import (
	"context"
	"github.com/jackc/pgx/v4"
	"github.com/joho/godotenv"
	"github.com/qcodelabsllc/crowdfundr/core/config"
	"log"
)

func main() {
	// load config from env file
	if err := godotenv.Load(); err != nil {
		log.Fatal("Error loading .env file")
	}

	// initialize database connection
	config.InitDatabase()
	defer func(CoreDb *pgx.Conn) {
		_ = CoreDb.Close(context.Background())
	}(config.CoreDb)

	// start gRPC server
	config.StartServer()

}
