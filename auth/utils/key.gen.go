package utils

import (
	cryptorand "crypto/rand"
	"golang.org/x/crypto/ed25519"
)

func GenerateKey() ([]byte, []byte) {
	pubKey, privKey, err := ed25519.GenerateKey(cryptorand.Reader)
	if err != nil {
		panic(err)
	}
	return pubKey, privKey
}
