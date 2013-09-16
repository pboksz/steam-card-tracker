class CreateDailyStats < ActiveRecord::Migration
  def change
    create_table :daily_stats do |t|
      t.string :currency_symbol, :default => '$'
      t.integer :min_price_low_integer, :default => 0
      t.integer :min_price_high_integer, :default => 0
      t.integer :quantity_low, :default => 0
      t.integer :quantity_high, :default => 0
      t.integer :item_id

      t.timestamps
    end
  end
end
