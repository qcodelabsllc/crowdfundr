package config

import (
	"context"
	"fmt"
	"github.com/jackc/pgx/v4"
	"log"
	"os"
)

// CoreDb global instance of postgresql database connection
var CoreDb *pgx.Conn

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
	var pgConn *pgx.Conn
	if conn, err := pgx.ConnectConfig(context.Background(), parsedConfig); err != nil {
		log.Fatal("unable to connect to database")
	} else {
		fmt.Println("Connected to PostgreSQL database!")
		pgConn = conn
	}

	// Check if connection was successful
	if err := pgConn.Ping(context.Background()); err != nil {
		log.Fatal("unable to ping database")
	}

	// Set global database connection
	CoreDb = pgConn
}
