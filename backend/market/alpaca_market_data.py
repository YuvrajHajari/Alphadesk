import os
from datetime import datetime, timedelta
from alpaca.data.historical import StockHistoricalDataClient
from alpaca.data.requests import StockBarsRequest
from alpaca.data.timeframe import TimeFrame

class AlpacaMarketData:
    def __init__(self):
        # Initialize Alpaca client using environment variables
        self.stock_client = StockHistoricalDataClient(
            api_key=os.getenv('ALPACA_API_KEY'),
            secret_key=os.getenv('ALPACA_SECRET_KEY')
        )

    def get_5min_bars(self, symbol: str, lookback_days: int = 5):
        """
        Fetch OHLCV bars for the given symbol using Alpaca Historical Data API.
        Replaces legacy yfinance integration.
        """
        end_date = datetime.now()
        start_date = end_date - timedelta(days=lookback_days)

        request_params = StockBarsRequest(
            symbol_or_symbols=symbol,
            timeframe=TimeFrame.Minute,
            start=start_date,
            end=end_date
        )

        bars = self.stock_client.get_stock_bars(request_params)
        return bars.df

if __name__ == "__main__":
    fetcher = AlpacaMarketData()
    print("Alpaca data client initialized successfully.")
