## Database

Postgres:

    create role ifpim createdb login;
    create database ifpim owner ifpim;

## Migrations

Migrations are handled by [migrate](https://github.com/golang-migrate/migrate).  See the [command line installation instructions](https://github.com/golang-migrate/migrate/tree/master/cmd/migrate) to install.

Create migration:

    $ cd PROJECT_ROOT
    $ migrate create -ext sql -dir db/migrations your_migration_name

Run migration:

    $ cd PROJECT_ROOT
    $ migrate -database postgres://ifpim@localhost:5432/ifpim?sslmode=disable -path db/migrations up
