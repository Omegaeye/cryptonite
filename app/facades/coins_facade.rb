class CoinsFacade

  def self.seed_db_crypto_market_info
    CoinsService.get_data.each do |data|
      Coin.create(
        name: data[:name].downcase,
        symbol: data[:symbol].downcase,
        usd_price: data[:priceUsd],
        btc_price: data[:priceBtc],
        percent_change: data[:percentChange24hUsd].to_f.round(5).to_s + '%'
      )
    end
  end
end