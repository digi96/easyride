postgres:
	docker run --name easyride-db -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

createdb:
	docker exec -it easyride-db createdb --username=root --owner=root easyride

dropdb:
	docker exec -it easyride-db dropdb easyride

migrateup:
	migrate -path db/migration -database "postgres://root:secret@localhost:5432/easyride?sslmode=disable" --verbose up

migratedown:
	migrate -path db/migration -database "postgres://root:secret@localhost:5432/easyride?sslmode=disable" --verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...


.PHONY: postgres createdb dropdb migrateup migratedown sqlc test