class Coin < ApplicationRecord
  validates :btc_price, 
                :name,    
                :percent_change,
                :symbol, 
                :usd_price, 
                presence: true
  
  def self.sorting_params(params)
    valid_float_params = %w[usd_price btc_price percent_change]
    valid_string_params = %w[name symbol]
    if valid_float_params.include?(params.to_s.downcase)
      order(params + ' DESC')
    elsif valid_string_params.include?(params.to_s.downcase)
      order(params + ' ASC')
    else
      order(name: :asc)
    end
  end

  def self.min_max_usd_price(min = nil, max = nil)
    min = 0 if min.nil?
    max = (1/0.0) if max.to_f == 0 || max.nil?
    where('usd_price > ? AND usd_price < ?', min.to_f, max.to_f)
  end
  
  def self.min_max_btc_price(min = nil, max = nil)
    min = 0 if min.nil?
    max = (1/0.0) if max.to_f == 0 || max.nil?
    where('btc_price > ? AND btc_price < ?', min.to_f, max.to_f)
  end

   def self.min_max_percent_change(min = nil, max = nil)
      min = -(1/0.0) if min.to_f == 0 || min.nil?
      max = (1/0.0) if max.to_f == 0 || max.nil?
      where('percent_change > ? AND percent_change < ?', min.to_f, max.to_f)
  end

  def self.search_coins(params)
    coin = Coin.all
    coin = coin.where(['name ILIKE ?', "%#{params[:name]}%"]) if params[:name].present?
    coin = coin.where(['symbol ILIKE ?', "%#{params[:symbol]}%"]) if params[:symbol].present?
    coin = coin.min_max_usd_price(params[:min_usd_price], params[:max_usd_price]) if params[:min_usd_price].present? || params[:max_usd_price].present? 
    coin = coin.min_max_btc_price(params[:min_btc_price], params[:max_btc_price]) if params[:min_btc_price].present? || params[:max_btc_price].present? 
    coin = coin.min_max_percent_change(params[:min_percent_change], params[:max_percent_change]) if params[:min_percent_change].present? || params[:max_percent_change].present? 
    return coin
  end
end
