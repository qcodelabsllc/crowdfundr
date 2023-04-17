package services

import (
	"context"
	"github.com/google/uuid"
	"github.com/jackc/pgx/v4"
	pb "github.com/qcodelabsllc/crowdfundr/core/gen"
	"golang.org/x/crypto/bcrypt"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	"google.golang.org/protobuf/types/known/emptypb"
	"google.golang.org/protobuf/types/known/wrapperspb"
)

type UserServiceImpl struct {
	db *pgx.Conn
	pb.UnimplementedUserServiceServer
}

// NewUserServiceImpl creates a new UserServiceImpl instance with the given db connection
func NewUserServiceImpl(db *pgx.Conn) *UserServiceImpl {
	return &UserServiceImpl{db: db}
}

func (s *UserServiceImpl) CreateUser(ctx context.Context, req *pb.CreateUserRequest) (*pb.User, error) {

	// get request data
	email := req.GetEmail()
	password := req.GetPassword()
	username := req.GetUsername()

	// encrypt password
	encryptedPassword, _ := encryptPassword(password)

	// create a new id for the user using uuid
	id, _ := uuid.NewRandom()

	// create user
	if _, err := s.db.Exec(ctx, "INSERT INTO crowdfundr_schema.users (id, email, password, username) VALUES ($1, $2, $3, $4)", id, email, encryptedPassword, username); err != nil {
		return nil, status.Errorf(codes.Internal, "unable to create user: %v", err)
	}

	// get the newly created user
	var user pb.User
	if err := s.db.QueryRow(ctx, "SELECT id, email, username FROM crowdfundr_schema.users WHERE id = $1", id).Scan(&user.Id, &user.Email, &user.Username); err != nil {
		return nil, status.Errorf(codes.Internal, "unable to get user: %v", err)
	}

	// return response
	return &user, nil
}

func (s *UserServiceImpl) GetUser(ctx context.Context, req *wrapperspb.StringValue) (*pb.User, error) {
	return &pb.User{}, nil
}

func (s *UserServiceImpl) UpdateUser(ctx context.Context, req *pb.User) (*pb.User, error) {
	return &pb.User{}, nil
}

func (s *UserServiceImpl) DeleteUser(ctx context.Context, req *wrapperspb.StringValue) (*emptypb.Empty, error) {
	return &emptypb.Empty{}, nil
}

// encryptPassword encrypts the given password using bcrypt
func encryptPassword(password string) (string, error) {
	// Generate a salt
	hashed, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	if err != nil {
		return "", err
	}

	// Return the hashed password as a string
	return string(hashed), nil
}

// ComparePassword compares the given password with the given hash
func comparePassword(password, hash string) bool {
	// Compare the password with the hash
	err := bcrypt.CompareHashAndPassword([]byte(hash), []byte(password))
	return err == nil
}
