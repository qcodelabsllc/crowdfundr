package config

import (
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
	"log"
	"net"
)

// StartServer starts the gRPC server
func StartServer() {
	// create grpc server
	grpcServer := grpc.NewServer()

	// setup reflection
	reflection.Register(grpcServer)

	// define address to listen on
	address := "[::]:42023" // april 2023

	// listen on address
	if listener, err := net.Listen("tcp", address); err != nil {
		log.Fatalf("unable to listen on %s: %v", address, err)
	} else {
		// start server
		log.Printf("gRPC server started on %s", address)
		if err := grpcServer.Serve(listener); err != nil {
			log.Fatalf("unable to serve: %v", err)
		}
	}
}
