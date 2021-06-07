class Search < ApplicationRecord
  validates :name, uniqueness: {scope: [:min_btc_price, 
                                                        :max_btc_price, 
                                                        :min_usd_price, 
                                                        :max_usd_price,  
                                                        :min_percent_change, 
                                                        :max_percent_change, 
                                                        :symbol]}

end
