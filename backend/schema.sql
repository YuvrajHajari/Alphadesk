-- backend/schema.sql
-- Run once against TimescaleDB to initialize all tables

CREATE EXTENSION IF NOT EXISTS timescaledb;

CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  clerk_id TEXT UNIQUE NOT NULL,
  email TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS strategies (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id),
  name TEXT NOT NULL,
  symbols TEXT[] NOT NULL,
  strategy_type TEXT NOT NULL,
  risk_budget_pct NUMERIC(5,2) DEFAULT 5.0,
  initial_capital NUMERIC(12,2) DEFAULT 100000.00,
  use_sentiment BOOLEAN DEFAULT true,
  is_active BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS market_bars (
  time TIMESTAMPTZ NOT NULL,
  symbol TEXT NOT NULL,
  open NUMERIC(10,4),
  high NUMERIC(10,4),
  low NUMERIC(10,4),
  close NUMERIC(10,4),
  volume BIGINT
);

SELECT create_hypertable('market_bars', 'time', if_not_exists => TRUE);
CREATE INDEX IF NOT EXISTS idx_market_bars_symbol_time ON market_bars (symbol, time DESC);

CREATE TABLE IF NOT EXISTS trade_fills (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  strategy_id UUID REFERENCES strategies(id),
  symbol TEXT NOT NULL,
  side TEXT NOT NULL,
  qty NUMERIC(10,4) NOT NULL,
  fill_price NUMERIC(10,4) NOT NULL,
  rationale TEXT,
  signal_type TEXT,
  sentiment_score NUMERIC(4,3),
  filled_at TIMESTAMPTZ DEFAULT NOW()
);

SELECT create_hypertable('trade_fills', 'filled_at', if_not_exists => TRUE);

CREATE TABLE IF NOT EXISTS portfolio_snapshots (
  time TIMESTAMPTZ NOT NULL,
  strategy_id UUID REFERENCES strategies(id),
  nav NUMERIC(12,2),
  cash NUMERIC(12,2),
  positions JSONB,
  daily_return_pct NUMERIC(6,4),
  total_return_pct NUMERIC(6,4)
);

SELECT create_hypertable('portfolio_snapshots', 'time', if_not_exists => TRUE);
