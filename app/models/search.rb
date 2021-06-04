class Search < ApplicationRecord
  validates :name, :symbol, presence: true

  def search_coins
    coin = Coin.all

    coin = coin.where(['name LIKE ?', name]) if name.present?
    coin = coin.where(['symbol LIKE ?', symbol]) if symbol.present?
    coin = coin.where(['usd_price LIKE ?', usd_price]) if usd_price.present?
    coin = coin.where(['btc_price LIKE ?', btc_price]) if btc_price.present?
    coin = coin.where(['percent_change LIKE ?', percent_change]) if percent_change.present?

    return coin
  end
  
end
