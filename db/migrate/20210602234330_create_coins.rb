class CreateCoins < ActiveRecord::Migration[5.2]
  def change
    create_table :coins do |t|
      t.string :name
      t.string :symbol
      t.decimal :usd_price
      t.string :btc_price
      t.integer :percent_change

      t.timestamps
    end
  end
end
