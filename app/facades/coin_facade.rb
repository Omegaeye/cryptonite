class CoinsFacade

  def self.crypto_market_info
    array.each do |name|
      ShrimpyService.get_data.each do |data|
        if data[:symbol] == name
          Coin.create(
            name: data[:name],
            symbol: data[:symbol],
            usd_price: data[:priceUsd],
            btc_price: data[:priceBtc],
            percent_change: data[:percentChange24hUsd]
          )
        end
      end
    end
  end
end