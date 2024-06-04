from fastapi import FastAPI

from members_agenda_api.api import API_ROUTER

app = FastAPI()


@app.get('/')
def read_root():
    return {'Hello': 'World'}

app.include_router(API_ROUTER)
