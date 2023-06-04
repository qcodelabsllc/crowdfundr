package config

import (
	"context"
	"fmt"
	"github.com/jackc/pgx/v5"
	"log"
	"os"
)

// UserDb global instance of postgresql database connection
var UserDb *pgx.Conn

// InitDatabase initializes the database connection
func InitDatabase() {
	// Set connection parameters
	var parsedConfig *pgx.ConnConfig
	if config, err := pgx.ParseConfig(""); err != nil {
		log.Fatal("unable to parse config")
	} else {
		parsedConfig = config
	}

	// Set connection parameters
	parsedConfig.Host = os.Getenv("DB_HOST")
	parsedConfig.Port = 5432
	parsedConfig.User = os.Getenv("DB_USER")
	parsedConfig.Password = os.Getenv("DB_PASSWORD")
	parsedConfig.Database = os.Getenv("DB_NAME")
	parsedConfig.RuntimeParams = map[string]string{
		"search_path": os.Getenv("DB_SCHEMA"),
	}

	// Establish database connection
	if conn, err := pgx.ConnectConfig(context.Background(), parsedConfig); err != nil {
		log.Fatal("unable to connect to database")
	} else {
		fmt.Println("Connected to PostgreSQL database!")
		// Set global database connection
		UserDb = conn
	}

	// Check if connection was successful
	if err := UserDb.Ping(context.Background()); err != nil {
		log.Fatal("unable to ping database")
	}

}
