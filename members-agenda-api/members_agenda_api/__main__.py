from contextlib import asynccontextmanager
from logging import getLogger

from fastapi import FastAPI

from members_agenda_api.api import API_ROUTER
from members_agenda_api.services import load_services, get_data_service


LOGGER = getLogger('uvicorn')

@asynccontextmanager
async def app_lifespan(app: FastAPI):
    # loads the services used by the application
    LOGGER.info('- Starting web API, loading services...')
    load_services()
    LOGGER.info('- Services loaded')
    yield

    # Clean up the ML models and release the resources
    LOGGER.info('- API server shutting down, closing db connection...')
    get_data_service().mysql_connection.close()
    LOGGER.info('- Database connection closed')

app = FastAPI(lifespan=app_lifespan)

@app.get('/')
def read_root():
    return {'Hello': 'World'}

app.include_router(API_ROUTER)
