# members-agenda
Dispatch team members in the agenda of a conference

## Dev environment

Frontend application

```sh
cd members-agenda-app

# starts the dev web server (exposed to the dockerized nginx) in a terminal
npm run dev-nginx

# starts nginx in another terminal
docker compose up
```

Backend API

```sh
cd members-agenda-api

# starts the web API (exposed to the dockerized nginx)
set -a && source .env && set +a && poetry run uvicorn members_agenda_api.__main__:app --host 0.0.0.0 --port 8282 --reload

# starts mysql and phpmyadmin in another terminal
docker compose up
```