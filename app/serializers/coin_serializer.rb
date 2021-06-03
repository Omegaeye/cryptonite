class CoinSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :symbol, :usd_price, :btc_price, :percent_change
end
