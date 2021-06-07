class CreateSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :searches do |t|
      t.string :name
      t.string :symbol
      t.float :min_usd_price
      t.float :max_usd_price
      t.float :min_btc_price
      t.float :max_btc_price
      t.float :min_percent_change
      t.float :max_percent_change
      t.timestamps
    end
  end
end
