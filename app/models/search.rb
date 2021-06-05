class Search < ApplicationRecord
  validates :name, uniqueness: {scope: [:symbol, :usd_price, :btc_price, :percent_change]}

  def search_coins
    coin = Coin.all
    
    coin = coin.where(['name ILIKE ?', "%#{name}%"]) if name.present?
    coin = coin.where(['symbol ILIKE ?', "%#{symbol}%"]) if symbol.present?
    coin = coin.where('usd_price >= ?', usd_price.to_i).order(:name) if usd_price.present?
    coin = coin.where(['btc_price ILIKE ?', "%#{btc_price}%"]) if btc_price.present?
    coin = coin.where('percent_change >= ?', percent_change) if percent_change.present?

    return coin
  end

  
end
