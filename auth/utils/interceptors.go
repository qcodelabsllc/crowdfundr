package utils

import (
	"context"
	"google.golang.org/grpc"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	"log"
)

// ValidatePublicTokenUnaryInterceptor create a grpc interceptor to validate the public token
func ValidatePublicTokenUnaryInterceptor(ctx context.Context, req interface{}, info *grpc.UnaryServerInfo, handler grpc.UnaryHandler) (interface{}, error) {
	log.Printf("FullMethod: %v", info.FullMethod)
	switch info.FullMethod {
	case "/crowdfunding.UserService/RequestPublicToken":
		return handler(ctx, req)
	case "/crowdfunding.UserService/RegisterUser", "/crowdfunding.UserService/LoginUser":
		// get public token from header
		if GetPublicTokenFromHeaderAndValidate(ctx) {
			// continue execution
			return handler(ctx, req)
		}
		return nil, status.Errorf(codes.Unauthenticated, "You are not authorized to access this resource")

	default:
		// get access token from header
		if GetTokenFromHeaderAndValidate(ctx) {
			// continue execution
			return handler(ctx, req)
		}
		return nil, status.Errorf(codes.Unauthenticated, "You are not authorized to access this resource")
	}
}

// ValidatePublicTokenStreamInterceptor create a grpc interceptor to validate the public token
func ValidatePublicTokenStreamInterceptor(srv interface{}, ss grpc.ServerStream, info *grpc.StreamServerInfo, handler grpc.StreamHandler) error {
	log.Printf("FullMethod: %v", info.FullMethod)
	// get access token from header
	if !GetTokenFromHeaderAndValidate(ss.Context()) {
		return status.Errorf(codes.Unauthenticated, "Invalid access token")
	}

	// continue execution
	return handler(srv, ss)
}
