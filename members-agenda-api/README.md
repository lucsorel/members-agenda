# members-agenda-api

## Start the database environment

Inspired by:

- https://lucidar.me/fr/docker/mysql-and-phpmyadmin-with-docker-compose/
- https://docs.docker.com/compose/environment-variables/variable-interpolation/

- create an `.env` file to define the environment variables related to:

  - the database credentials
  - the folder where the database contents will be persisted

```ini
MYSQL_HOST=localhost
MYSQL_PORT=6033
MEMBERS_AGENDA_MYSQL_VOLUME=/{path/to/project/folder}/members-agenda-api/.local/mysql-volume
MEMBERS_AGENDA_DATABASE=members_agenda
MEMBERS_AGENDA_USER=members_agenda
MEMBERS_AGENDA_PASSWORD=Members-agendA
```

It will be used both by:

- docker compose to initialize and run the database
- the web application to connect to the database

- test the docker compose config:

```sh
docker compose config
```

- start the phpmyadmin and mysql stack

```sh
docker compose up
```

- PhpMyAdmin will be available: http://localhost:8081/

- stop the phpmyadmin and mysql stack

```sh
docker compose down
```

## Start the web API

```sh
set -a && source .env && set +a && poetry run uvicorn members_agenda_api.__main__:app --port 8282 --reload
```
