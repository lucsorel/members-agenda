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

- `docker compose` to initialize and run the database
- the web application to connect to the database

- test the `docker compose` config:

```sh
docker compose config
```

- start the phpmyadmin and mysql stack

```sh
docker compose up
```

- PhpMyAdmin will be available at http://localhost:8081/

- stop the phpmyadmin and mysql stack

```sh
docker compose down
```

## Start the web API

Sources the environment variables and starts the web server on port `8282`:

```sh
set -a && source .env && set +a && poetry run uvicorn members_agenda_api.__main__:app --port 8282 --reload
```

## Endpoints examples

```sh
# all events
http://localhost:8282/api/agenda

# all venues
http://localhost:8282/api/venues

# all slots
http://localhost:8282/api/slots

# slots that intersect a period of time delimited by start and end datetimes
http://localhost:8282/api/slots/intersect?start=2024-06-25T09:30:00&end=2024-06-25T10:30:00
```

```sh
# person details
curl http://localhost:8282/api/people/79 -i

curl http://localhost:8282/api/people/-1 -i
curl http://localhost:8282/api/people/666 -i

# adds member 79 (Luc) to slot 44 (assist Amphi A between 2024-06-27 10:15:00 and 12:30:00)
curl -X POST "http://127.0.0.1:8282/api/slots/44/add-member?member_id=79" -i
#{
#  "message":"person already involved during this period",
#  "member_slots":[],
#  "speaker_events":[
#    {"id":22,"title":"Testcontainers : tu ne douteras plus de tes fonctionnalités, jeune Pydawan·e","start":"2024-06-27T10:30:00","end":"2024-06-27T11:25:00","venue_id":4}
#  ]
# }

curl -X POST "http://127.0.0.1:8282/api/slots/44/add-member?member_id=25" -i 
#{"detail":"Person of id 25 is not a member"}
```