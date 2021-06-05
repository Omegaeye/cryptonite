class CreateSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :searches do |t|
      t.string :name
      t.string :symbol
      t.float :usd_price
      t.float :btc_price
      t.float :percent_change

      t.timestamps
    end
  end
end
