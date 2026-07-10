# backend/config.py
# Pydantic settings — reads from .env.local automatically
from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    alpaca_api_key: str = ""
    alpaca_secret_key: str = ""
    alpaca_base_url: str = "https://paper-api.alpaca.markets"
    alpaca_data_url: str = "wss://stream.data.alpaca.markets/v2/iex"

    groq_api_key: str = ""

    pinecone_api_key: str = ""
    pinecone_index_name: str = "alphadesk"

    news_api_key: str = ""

    database_url: str = "postgresql+asyncpg://alphadesk:password@localhost:5432/alphadesk"
    redis_url: str = "redis://localhost:6379"

    railway_static_url: str = ""

    class Config:
        env_file = ".env.local"

settings = Settings()
