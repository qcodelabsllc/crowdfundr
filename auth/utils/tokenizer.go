package utils

import (
	"context"
	"encoding/hex"
	"errors"
	"github.com/google/uuid"
	"github.com/o1egl/paseto"
	"golang.org/x/crypto/ed25519"
	"google.golang.org/grpc/metadata"
	"log"
	"os"
	"time"
)

// reference: http://www.unit-conversion.info/texttools/random-string-generator/
const (
	payloadIssuer     = "crowdfundr"
	payloadType       = "basic_app_access"
	payloadSub        = "crowdfundr-access-token"
	publicPayloadType = "public_api_access"
	publicPayloadSub  = "crowdfundr-public-access-token"
	publicKeyHeader   = "x-crowdfundr-pub-key"
)

type TokenPayload struct {
	AccessToken  string
	RefreshToken string
}

type PublicTokenPayload struct {
	Token     string
	PublicKey string
}

// CreateTokenForUser creates access & refresh tokens for a user
func CreateTokenForUser(uid string) (*TokenPayload, error) {
	// get symmetric key from env
	symmetricKey := []byte(os.Getenv("PASETO_SYMMETRIC_KEY"))

	// create access token
	now := time.Now()
	accessTokenExp := now.Add(24 * time.Hour) // 24 hours
	nbt := now
	jsonToken := paseto.JSONToken{
		Audience:  uid,
		Issuer:    payloadIssuer,
		Jti:       uid,
		Subject:   payloadSub,
		IssuedAt:  now,
		NotBefore: nbt,
	}
	jsonToken.Expiration = accessTokenExp
	jsonToken.Set("type", payloadType)

	accessToken, err := paseto.NewV2().Encrypt(symmetricKey, jsonToken, nil)
	if err != nil {
		return nil, errors.New("unable to create access token")
	}

	// create refresh token
	refreshTokenExp := now.Add(24 * 30 * time.Hour) // 30 days
	jsonToken.Expiration = refreshTokenExp

	refreshToken, err := paseto.NewV2().Encrypt(symmetricKey, jsonToken, nil)
	if err != nil {
		return nil, errors.New("unable to create refresh token")
	}

	// create payload
	payload := &TokenPayload{
		AccessToken:  accessToken,
		RefreshToken: refreshToken,
	}

	return payload, nil
}

// CreatePublicAccessTokenForUser creates a public access token for a user (used for public endpoints) and expires in 12 hours
func CreatePublicAccessTokenForUser() (*PublicTokenPayload, error) {
	publicKey, privateKey := GenerateKey()

	// create payload
	now := time.Now()
	accessTokenExp := now.Add(12 * time.Hour) // 12 hours
	nbt := now
	aud := uuid.NewString()
	payload := paseto.JSONToken{
		Audience:  aud,
		Issuer:    payloadIssuer,
		Jti:       aud,
		Subject:   publicPayloadSub,
		IssuedAt:  now,
		NotBefore: nbt,
	}
	payload.Expiration = accessTokenExp
	payload.Set("type", publicPayloadType)

	// sign token
	token, err := paseto.NewV2().Sign(ed25519.PrivateKey(privateKey), payload, nil)
	if err != nil {
		log.Printf("Unable to sign token: %v", err)
		return nil, errors.New("unable to create public key")
	}

	key := hex.EncodeToString(publicKey)
	log.Printf("Public key: %v", key)
	// create payload
	publicPayload := &PublicTokenPayload{
		Token:     token,
		PublicKey: key,
	}
	return publicPayload, nil
}

// ValidateToken validates a local token
func ValidateToken(token string) bool {
	var payload paseto.JSONToken
	if result, err := decryptToken(token); err != nil {
		log.Printf("Unable to decrypt token: %v", err)
		return false
	} else {
		payload = *result
	}

	// check for expiration
	if payload.Expiration.Before(time.Now()) {
		log.Printf("Token has expired")
		return false
	}

	// check for not before
	if payload.NotBefore.After(time.Now()) {
		log.Printf("Token is not valid yet")
		return false
	}

	// check for issuer
	if payload.Issuer != payloadIssuer {
		log.Printf("Token issuer is invalid")
		return false
	}

	// check for subject
	if payload.Subject != payloadSub {
		log.Printf("Token subject is invalid")
		return false
	}

	// check for type
	if payload.Get("type") != payloadType {
		log.Printf("Token type is invalid")
		return false
	}

	return true
}

// ValidatePublicToken validates a public token
func ValidatePublicToken(tokenPayload PublicTokenPayload) bool {
	pubKey, err := hex.DecodeString(tokenPayload.PublicKey)
	if err != nil {
		return false
	}

	var payload paseto.JSONToken
	if err := paseto.NewV2().Verify(tokenPayload.Token, ed25519.PublicKey(pubKey), &payload, nil); err != nil {
		return false
	}

	// check for expiration
	if payload.Expiration.Before(time.Now()) {
		log.Printf("Token has expired")
		return false
	}

	// check for not before
	if payload.NotBefore.After(time.Now()) {
		log.Printf("Token is not valid yet")
		return false
	}

	// check for issuer
	if payload.Issuer != payloadIssuer {
		log.Printf("Token issuer is invalid")
		return false
	}

	// check for subject
	if payload.Subject != publicPayloadSub {
		log.Printf("Token subject is invalid")
		return false
	}

	// check for type
	if payload.Get("type") != publicPayloadType {
		log.Printf("Token type is invalid")
		return false
	}

	return true
}

// GetTokenFromHeader gets a token from the authorization header
func GetTokenFromHeader(ctx context.Context) (*string, error) {
	// get metadata
	md, ok := metadata.FromIncomingContext(ctx)
	if !ok {
		return nil, errors.New("unable to get metadata")
	}

	if md.Get("authorization") == nil || len(md.Get("authorization")) == 0 {
		return nil, errors.New("authorization header is missing")
	}

	// get authorization header
	header := md.Get("authorization")[0]

	// check for bearer
	if len(header) < 8 || header[:7] != "Bearer " {
		return nil, errors.New("invalid authorization header")
	}

	token := header[7:]
	return &token, nil
}

// GetTokenFromHeaderAndValidate gets a token from the authorization header and validates it
func GetTokenFromHeaderAndValidate(ctx context.Context) bool {
	// get token from header
	token, err := GetTokenFromHeader(ctx)
	if err != nil {
		return false
	}

	// validate token
	return ValidateToken(*token)
}

// GetPublicTokenFromHeaderAndValidate gets a public token from the authorization header and validates it
func GetPublicTokenFromHeaderAndValidate(ctx context.Context) bool {
	// get token from header
	token, err := GetTokenFromHeader(ctx)
	if err != nil {
		return false
	}

	// get public key from metadata
	md, ok := metadata.FromIncomingContext(ctx)
	if !ok {
		log.Printf("Unable to get metadata")
		return false
	}

	// get public key
	publicKey := md.Get(publicKeyHeader)[0]

	payload := &PublicTokenPayload{
		Token:     *token,
		PublicKey: publicKey,
	}

	// validate token
	return ValidatePublicToken(*payload)
}

// decryptToken decrypts a token
func decryptToken(token string) (*paseto.JSONToken, error) {
	// get symmetric key from env
	symmetricKey := []byte(os.Getenv("PASETO_SYMMETRIC_KEY"))
	var payload paseto.JSONToken
	err := paseto.NewV2().Decrypt(token, symmetricKey, &payload, nil)
	if err != nil {
		log.Printf("Unable to decrypt token: %v", err)
		return nil, errors.New("unable to decrypt token")
	}
	return &payload, nil
}
