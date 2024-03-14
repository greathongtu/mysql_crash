# migrate create -ext sql -dir migrations -seq first_try
createmysql:
	docker run --name mysql8 -e MYSQL_ROOT_PASSWORD=secret -p 3306:3306 -d mysql:latest
# docker exec -it mysql bash
createdb:
	docker exec -it mysql8 mysql -uroot -psecret -e "create database if not exists land"

dropdb:
	docker exec -it mysql8 mysql -uroot -psecret -e "drop database if exists land"

migrateup:
	migrate -path ./migrations -database "mysql://root:secret@tcp(localhost:3306)/land" -verbose up

migratedown:
	migrate -path ./migrations -database "mysql://root:secret@tcp(localhost:3306)/land" -verbose down
