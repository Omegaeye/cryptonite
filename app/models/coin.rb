class Coin < ApplicationRecord
  validates :name, :symbol, :usd_price, :btc_price, :percent_change, presence: true

  def self.pagination_helper(page = 1, per_page = 20)
    page = 1 if page < 1
    per_page = 20 if per_page < 1
    offset = ((page - 1) * per_page)
    self.offset(offset).limit(per_page)
  end

  def self.sorting_params(params)
    valid_float_params = %w[usd_price btc_price percent_change]
    valid_string_params = %w[name symbol]

    if valid_float_params.include?(params.downcase)
      order(params + ' DESC')
    elsif valid_string_params.include?(params.downcase)
      order(params + ' ASC')
    else
      order(name: :asc)
    end
  end
end
