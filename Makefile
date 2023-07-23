ispost:
	docker run --name spostgres15 -p 5432:5432 -e POSTGRES_USER=phadoo -e POSTGRES_PASSWORD=phadoosecret -d postgres:15.3-alpine

createdb:
	docker exec -it spostgres15 createdb --username=phadoo --owner=phadoo simple_bank
	
execdb:
	docker exec -it spostgres15 psql -U phadoo -d simple_bank

dropdb:
	docker exec -it spostgres15 dropdb simple_bank	

migrateup:
	migrate -path simplebank/db/migration -database "postgresql://phadoo:phadoosecret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path simplebank/db/migration -database "postgresql://phadoo:phadoosecret@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: ispost createdb dropdb migrateup migratedown sqlc execdb