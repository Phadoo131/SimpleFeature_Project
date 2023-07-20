package db

import (
	"testing"
	"log"
	"os"
	"database/sql"

	_"github.com/lib/pq"
)
var testQuerie *Queries
var testDB *sql.DB

const (
	dbDriver = "postgres"
	dbSource = "postgresql://phadoo:phadoosecret@localhost:5432/simple_bank?sslmode=disable"
)

func TestMain(m *testing.M){
	var err error

	testDB, err = sql.Open(dbDriver, dbSource)
	if err != nil {
		log.Fatal("Cannot connect to the DB: ", err)
	}

	testQuerie = New(testDB)

	os.Exit(m.Run())
}