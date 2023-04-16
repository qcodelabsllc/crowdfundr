// Code generated by protoc-gen-go-grpc. DO NOT EDIT.
// versions:
// - protoc-gen-go-grpc v1.2.0
// - protoc             v3.15.8
// source: project_service.proto

package crowdfundr

import (
	context "context"
	grpc "google.golang.org/grpc"
	codes "google.golang.org/grpc/codes"
	status "google.golang.org/grpc/status"
	emptypb "google.golang.org/protobuf/types/known/emptypb"
)

// This is a compile-time assertion to ensure that this generated file
// is compatible with the grpc package it is being compiled against.
// Requires gRPC-Go v1.32.0 or later.
const _ = grpc.SupportPackageIsVersion7

// ProjectServiceClient is the client API for ProjectService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
type ProjectServiceClient interface {
	// Event triggered when a new project is created
	ProjectCreated(ctx context.Context, in *Project, opts ...grpc.CallOption) (*emptypb.Empty, error)
	// Event triggered when a project is updated
	ProjectUpdated(ctx context.Context, in *Project, opts ...grpc.CallOption) (*emptypb.Empty, error)
	// Event triggered when a new user is added to a project
	UserAddedToProject(ctx context.Context, in *ProjectMember, opts ...grpc.CallOption) (*emptypb.Empty, error)
}

type projectServiceClient struct {
	cc grpc.ClientConnInterface
}

func NewProjectServiceClient(cc grpc.ClientConnInterface) ProjectServiceClient {
	return &projectServiceClient{cc}
}

func (c *projectServiceClient) ProjectCreated(ctx context.Context, in *Project, opts ...grpc.CallOption) (*emptypb.Empty, error) {
	out := new(emptypb.Empty)
	err := c.cc.Invoke(ctx, "/crowdfunding.ProjectService/ProjectCreated", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *projectServiceClient) ProjectUpdated(ctx context.Context, in *Project, opts ...grpc.CallOption) (*emptypb.Empty, error) {
	out := new(emptypb.Empty)
	err := c.cc.Invoke(ctx, "/crowdfunding.ProjectService/ProjectUpdated", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *projectServiceClient) UserAddedToProject(ctx context.Context, in *ProjectMember, opts ...grpc.CallOption) (*emptypb.Empty, error) {
	out := new(emptypb.Empty)
	err := c.cc.Invoke(ctx, "/crowdfunding.ProjectService/UserAddedToProject", in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

// ProjectServiceServer is the server API for ProjectService service.
// All implementations must embed UnimplementedProjectServiceServer
// for forward compatibility
type ProjectServiceServer interface {
	// Event triggered when a new project is created
	ProjectCreated(context.Context, *Project) (*emptypb.Empty, error)
	// Event triggered when a project is updated
	ProjectUpdated(context.Context, *Project) (*emptypb.Empty, error)
	// Event triggered when a new user is added to a project
	UserAddedToProject(context.Context, *ProjectMember) (*emptypb.Empty, error)
	mustEmbedUnimplementedProjectServiceServer()
}

// UnimplementedProjectServiceServer must be embedded to have forward compatible implementations.
type UnimplementedProjectServiceServer struct {
}

func (UnimplementedProjectServiceServer) ProjectCreated(context.Context, *Project) (*emptypb.Empty, error) {
	return nil, status.Errorf(codes.Unimplemented, "method ProjectCreated not implemented")
}
func (UnimplementedProjectServiceServer) ProjectUpdated(context.Context, *Project) (*emptypb.Empty, error) {
	return nil, status.Errorf(codes.Unimplemented, "method ProjectUpdated not implemented")
}
func (UnimplementedProjectServiceServer) UserAddedToProject(context.Context, *ProjectMember) (*emptypb.Empty, error) {
	return nil, status.Errorf(codes.Unimplemented, "method UserAddedToProject not implemented")
}
func (UnimplementedProjectServiceServer) mustEmbedUnimplementedProjectServiceServer() {}

// UnsafeProjectServiceServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to ProjectServiceServer will
// result in compilation errors.
type UnsafeProjectServiceServer interface {
	mustEmbedUnimplementedProjectServiceServer()
}

func RegisterProjectServiceServer(s grpc.ServiceRegistrar, srv ProjectServiceServer) {
	s.RegisterService(&ProjectService_ServiceDesc, srv)
}

func _ProjectService_ProjectCreated_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(Project)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(ProjectServiceServer).ProjectCreated(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/crowdfunding.ProjectService/ProjectCreated",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(ProjectServiceServer).ProjectCreated(ctx, req.(*Project))
	}
	return interceptor(ctx, in, info, handler)
}

func _ProjectService_ProjectUpdated_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(Project)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(ProjectServiceServer).ProjectUpdated(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/crowdfunding.ProjectService/ProjectUpdated",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(ProjectServiceServer).ProjectUpdated(ctx, req.(*Project))
	}
	return interceptor(ctx, in, info, handler)
}

func _ProjectService_UserAddedToProject_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(ProjectMember)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(ProjectServiceServer).UserAddedToProject(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: "/crowdfunding.ProjectService/UserAddedToProject",
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(ProjectServiceServer).UserAddedToProject(ctx, req.(*ProjectMember))
	}
	return interceptor(ctx, in, info, handler)
}

// ProjectService_ServiceDesc is the grpc.ServiceDesc for ProjectService service.
// It's only intended for direct use with grpc.RegisterService,
// and not to be introspected or modified (even as a copy)
var ProjectService_ServiceDesc = grpc.ServiceDesc{
	ServiceName: "crowdfunding.ProjectService",
	HandlerType: (*ProjectServiceServer)(nil),
	Methods: []grpc.MethodDesc{
		{
			MethodName: "ProjectCreated",
			Handler:    _ProjectService_ProjectCreated_Handler,
		},
		{
			MethodName: "ProjectUpdated",
			Handler:    _ProjectService_ProjectUpdated_Handler,
		},
		{
			MethodName: "UserAddedToProject",
			Handler:    _ProjectService_UserAddedToProject_Handler,
		},
	},
	Streams:  []grpc.StreamDesc{},
	Metadata: "project_service.proto",
}
