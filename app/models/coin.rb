class Coin < ApplicationRecord
  validates :name, :symbol, :usd_price, :btc_price, :percent_change, presence: true
end
