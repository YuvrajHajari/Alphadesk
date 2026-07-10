# AlphaDesk

AI Hedge Fund Simulation Platform — paper trading with autonomous LangGraph agents.

## Stack
- **Frontend:** Next.js 15, Tailwind CSS, lightweight-charts
- **Backend:** FastAPI, LangGraph, Groq (llama3-70b)
- **Database:** TimescaleDB (PostgreSQL 16)
- **Cache:** Redis 7
- **Vector DB:** Pinecone (free tier)
- **Market Data:** Alpaca IEX (free)
- **Auth:** Clerk
- **Deploy:** Railway.app

## Quick Start
\`\`\`bash
cp .env.local .env.local  # fill in your API keys
docker compose up -d
\`\`\`
- UI: http://localhost:3000
- API: http://localhost:8000
- Grafana: http://localhost:3001
