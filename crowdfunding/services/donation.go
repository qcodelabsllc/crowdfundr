package services

import (
	"github.com/jackc/pgx/v4"
	pb "github.com/qcodelabsllc/crowdfundr/core/gen"
)

type DonationServiceImpl struct {
	db *pgx.Conn
	pb.UnimplementedDonationServiceServer
}

// NewDonationServiceImpl creates a new DonationServiceImpl instance with the given db connection
func NewDonationServiceImpl(db *pgx.Conn) *DonationServiceImpl {
	return &DonationServiceImpl{db: db}
}
