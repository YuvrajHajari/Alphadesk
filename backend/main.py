# backend/main.py
# FastAPI app entry point — register routers, startup events, health check
from fastapi import FastAPI

app = FastAPI(title="AlphaDesk API")

# TODO Phase 1: register routers
# TODO Phase 1: startup event for Alpaca streamer
# TODO Phase 1: keepalive self-ping for Railway

@app.get("/health")
async def health():
    return {"status": "alive"}
