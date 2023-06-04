package config

import (
	pb "github.com/qcodelabsllc/crowdfundr/auth/gen"
	svc "github.com/qcodelabsllc/crowdfundr/auth/services"
	"github.com/qcodelabsllc/crowdfundr/auth/utils"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
	"log"
	"net"
)

// StartServer starts the gRPC server
func StartServer() {
	// create grpc server
	grpcServer := grpc.NewServer(grpc.UnaryInterceptor(utils.ValidatePublicTokenUnaryInterceptor),
		grpc.StreamInterceptor(utils.ValidatePublicTokenStreamInterceptor))

	// register services
	pb.RegisterUserServiceServer(grpcServer, svc.NewUserServiceImpl(UserDb))

	// setup reflection
	reflection.Register(grpcServer)

	// define address to listen on
	address := "[::]:62023" // june (6) 2023

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
