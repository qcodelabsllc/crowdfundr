package services

import (
	"context"
	"github.com/google/uuid"
	"github.com/jackc/pgx/v5"
	pb "github.com/qcodelabsllc/crowdfundr/auth/gen"
	"github.com/qcodelabsllc/crowdfundr/auth/utils"
	"golang.org/x/crypto/bcrypt"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	"google.golang.org/protobuf/types/known/emptypb"
	"google.golang.org/protobuf/types/known/wrapperspb"
	"log"
)

type UserServiceImpl struct {
	db *pgx.Conn
	pb.UnimplementedUserServiceServer
}

// NewUserServiceImpl creates a new UserServiceImpl instance with the given db connection
func NewUserServiceImpl(db *pgx.Conn) *UserServiceImpl {
	return &UserServiceImpl{db: db}
}

// RegisterUser creates a new user account
func (s *UserServiceImpl) RegisterUser(ctx context.Context, req *pb.RegisterUserRequest) (*wrapperspb.StringValue, error) {

	// get request data
	email := req.GetEmail()
	password := req.GetPassword()
	username := req.GetUsername()
	avatar := req.GetAvatarUrl()

	// encrypt password
	encryptedPassword, _ := encryptPassword(password)

	// create a new id for the user using uuid
	id, _ := uuid.NewRandom()

	// create user
	if _, err := s.db.Exec(ctx, "INSERT INTO users (id, email, password, username, avatar) VALUES ($1, $2, $3, $4, $5)", id, email, encryptedPassword, username, avatar); err != nil {
		log.Printf("Unable to create user account: %v", err)
		return nil, status.Errorf(codes.Internal, "Unable to create user account. Please try again later.")
	}

	// get the newly created user
	var user pb.User
	if err := s.db.QueryRow(ctx, "SELECT id, email, username, avatar FROM users WHERE id = $1", id).Scan(&user.Id, &user.Email, &user.Username, &user.Avatar); err != nil {
		log.Printf("Unable to get user: %v", err)
		return nil, status.Errorf(codes.Internal, "An error occurred while creating your account. Please try again later.")
	}

	// create access & refresh tokens
	tokenPayload, err := utils.CreateTokenForUser(user.GetId())
	if err != nil {
		log.Printf("Unable to create tokens: %v", err)
		return nil, status.Errorf(codes.Internal, "An error occurred while creating your account. Please try again later.")
	}

	// @todo save refresh token to db

	return &wrapperspb.StringValue{Value: tokenPayload.AccessToken}, nil
}

// LoginUser logs in a user
func (s *UserServiceImpl) LoginUser(ctx context.Context, req *pb.LoginUserRequest) (*wrapperspb.StringValue, error) {

	var password string
	if err := s.db.QueryRow(ctx, "SELECT password FROM users WHERE email = $1", req.GetEmail()).Scan(&password); err != nil {
		log.Printf("Unable to get user: %v", err)
		return nil, status.Errorf(codes.Internal, "Login failed. Please check your email and password and try again")
	}

	// compare passwords
	valid := comparePassword(req.GetPassword(), password)
	if !valid {
		return nil, status.Errorf(codes.Internal, "Login failed. Please check your email and password and try again")
	}

	var user pb.User
	if err := s.db.QueryRow(ctx, "SELECT id, email, username, avatar FROM users WHERE email = $1", req.GetEmail()).Scan(&user.Id, &user.Email, &user.Username, &user.Avatar); err != nil {
		log.Printf("Unable to get user: %v", err)
		return nil, status.Errorf(codes.Internal, "Login failed. Please check your email and password and try again")
	}

	// create access & refresh tokens
	tokenPayload, err := utils.CreateTokenForUser(user.GetId())
	if err != nil {
		log.Printf("Unable to create tokens: %v", err)
		return nil, status.Errorf(codes.Internal, "Login failed. Please check your email and password and try again")
	}

	// @todo save refresh token to db

	return &wrapperspb.StringValue{Value: tokenPayload.AccessToken}, nil
}

// GetUser gets a user by id
func (s *UserServiceImpl) GetUser(ctx context.Context, req *wrapperspb.StringValue) (*pb.User, error) {
	valid := utils.GetTokenFromHeaderAndValidate(ctx)
	if !valid {
		return nil, status.Errorf(codes.Internal, "An error occurred while getting your account. Please try again later.")
	}

	var user pb.User
	if err := s.db.QueryRow(ctx, "SELECT id, email, username, avatar FROM users WHERE id = $1", req.GetValue()).Scan(&user.Id, &user.Email, &user.Username, &user.Avatar); err != nil {
		log.Printf("Unable to get user: %v", err)
		return nil, status.Errorf(codes.Internal, "An error occurred while getting your account. Please try again later.")
	}

	// return response
	return &user, nil
}

// UpdateUser updates a user
func (s *UserServiceImpl) UpdateUser(ctx context.Context, req *pb.User) (*pb.User, error) {

	// check if user exists
	var id string
	if err := s.db.QueryRow(ctx, "SELECT id FROM users WHERE id = $1", req.GetId()).Scan(&id); err != nil {
		log.Printf("Unable to get user: %v", err)
		return nil, status.Errorf(codes.Internal, "An error occurred while updating your account. Please try again later.")
	}

	// update user
	if _, err := s.db.Exec(ctx, "UPDATE users SET email = $1, username = $2, avatar = $3 WHERE id = $4", req.GetEmail(), req.GetUsername(), req.GetAvatar(), id); err != nil {
		log.Printf("Unable to update user: %v", err)
		return nil, status.Errorf(codes.Internal, "An error occurred while updating your account. Please try again later.")
	}

	// get the updated user
	var user pb.User
	if err := s.db.QueryRow(ctx, "SELECT id, email, username, avatar FROM users WHERE email = $1", req.GetEmail()).Scan(&user.Id, &user.Email, &user.Username, &user.Avatar); err != nil {
		log.Printf("Unable to get user: %v", err)
		return nil, status.Errorf(codes.Internal, "An error occurred while updating your account. Please try again later.")
	}

	return &user, nil
}

// DeleteUser deletes a user
func (s *UserServiceImpl) DeleteUser(ctx context.Context, req *wrapperspb.StringValue) (*emptypb.Empty, error) {

	// check if user exists
	var id string
	if err := s.db.QueryRow(ctx, "SELECT id FROM users WHERE id = $1", req.GetValue()).Scan(&id); err != nil {
		log.Printf("Unable to get user: %v", err)
		return nil, status.Errorf(codes.Internal, "An error occurred while deleting your account. Please try again later.")
	}

	// delete user
	if _, err := s.db.Exec(ctx, "DELETE FROM users WHERE id = $1", id); err != nil {
		log.Printf("Unable to delete user: %v", err)
		return nil, status.Errorf(codes.Internal, "An error occurred while deleting your account. Please try again later.")
	}

	return &emptypb.Empty{}, nil
}

// GetUserByEmail gets a user by email
func (s *UserServiceImpl) GetUserByEmail(ctx context.Context, req *wrapperspb.StringValue) (*pb.User, error) {
	// check if user exists
	var user pb.User
	if err := s.db.QueryRow(ctx, "SELECT id, email, username, avatar FROM users WHERE email = $1", req.GetValue()).Scan(&user.Id, &user.Email, &user.Username, &user.Avatar); err != nil {
		log.Printf("Unable to get user: %v", err)
		return nil, status.Errorf(codes.Internal, "An error occurred while deleting your account. Please try again later.")
	}
	return &user, nil
}

func (s *UserServiceImpl) LogoutUser(context.Context, *emptypb.Empty) (*emptypb.Empty, error) {
	// @todo delete access token from db
	return &emptypb.Empty{}, nil
}

func (s *UserServiceImpl) RequestPublicToken(context.Context, *emptypb.Empty) (*pb.PublicTokenResponse, error) {
	if payload, err := utils.CreatePublicAccessTokenForUser(); err != nil {
		log.Printf("Unable to create public token: %v", err)
		return nil, status.Errorf(codes.Internal, "An error occurred while creating your public token. Please try again later.")
	} else {
		response := &pb.PublicTokenResponse{
			PublicToken:          payload.Token,
			PublicTokenSignature: payload.PublicKey,
		}
		return response, nil
	}
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

// comparePassword compares the given password with the given hash
func comparePassword(password, hash string) bool {
	// Compare the password with the hash
	err := bcrypt.CompareHashAndPassword([]byte(hash), []byte(password))
	return err == nil
}
