package services

import (
	"database/sql"
	"fmt"

	_ "github.com/denisenkom/go-mssqldb"
	"github.com/portierglobal/cloud-migration-tools/rt/client/internal/config"
)

type SQLService struct {
	db *sql.DB
}

func NewSQLService(cfg *config.SQLConfig) (*SQLService, error) {
	connStr := fmt.Sprintf("server=localhost,%s;user id=%s;password=%s", cfg.Port, cfg.User, cfg.Password)
	db, err := sql.Open("sqlserver", connStr)
	if err != nil {
		return nil, fmt.Errorf("failed to connect to database: %w", err)
	}

	return &SQLService{db: db}, nil
}

func (s *SQLService) Close() error {
	return s.db.Close()
}

func (s *SQLService) ExecuteQuery(query string) ([]map[string]interface{}, error) {
	rows, err := s.db.Query(query)
	if err != nil {
		return nil, fmt.Errorf("error executing query: %w", err)
	}
	defer rows.Close()

	return fetchResults(rows)
}

func fetchResults(rows *sql.Rows) ([]map[string]interface{}, error) {
	var results []map[string]interface{}
	columns, err := rows.Columns()
	if err != nil {
		return nil, fmt.Errorf("failed to get columns: %w", err)
	}

	for rows.Next() {
		row := make(map[string]interface{})
		columnPointers := make([]interface{}, len(columns))

		for i := range columnPointers {
			columnPointers[i] = new(interface{})
		}

		if err := rows.Scan(columnPointers...); err != nil {
			return nil, fmt.Errorf("failed to scan row: %w", err)
		}

		for i, colName := range columns {
			row[colName] = *(columnPointers[i].(*interface{}))
		}

		results = append(results, row)
	}

	return results, rows.Err()
}
