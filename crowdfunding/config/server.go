package config

import (
	pb "github.com/qcodelabsllc/crowdfundr/core/gen"
	svc "github.com/qcodelabsllc/crowdfundr/core/services"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
	"log"
	"net"
)

// StartServer starts the gRPC server
func StartServer() {
	// create grpc server
	grpcServer := grpc.NewServer()

	// register services
	pb.RegisterUserServiceServer(grpcServer, svc.NewUserServiceImpl(CoreDb))
	pb.RegisterProjectServiceServer(grpcServer, svc.NewProjectServiceImpl(CoreDb))
	pb.RegisterDonationServiceServer(grpcServer, svc.NewDonationServiceImpl(CoreDb))

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
