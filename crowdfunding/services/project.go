package services

import (
	"github.com/jackc/pgx/v4"
	pb "github.com/qcodelabsllc/crowdfundr/core/gen"
)

type ProjectServiceImpl struct {
	db *pgx.Conn
	pb.UnimplementedProjectServiceServer
}

// NewProjectServiceImpl creates a new ProjectServiceImpl instance with the given db connection
func NewProjectServiceImpl(db *pgx.Conn) *ProjectServiceImpl {
	return &ProjectServiceImpl{db: db}
}
