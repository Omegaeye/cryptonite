class CoinsFacade

  def self.seed_db_crypto_market_info
    CoinsService.get_data.each do |data|
      Coin.create(
        name: data[:name],
        symbol: data[:symbol],
        usd_price: ActiveSupport::NumberHelper.number_to_currency(data[:priceUsd]),
        btc_price: data[:priceBtc],
        percent_change: % data[:percentChange24hUsd].to_f
      )
    end
  end
end