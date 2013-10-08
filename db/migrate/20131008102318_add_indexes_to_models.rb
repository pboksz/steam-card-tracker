class AddIndexesToModels < ActiveRecord::Migration
  def change
    add_index :items, :name
    add_index :items, :foil
    add_index :daily_stats, :min_price_low_integer
    add_index :daily_stats, :min_price_high_integer
    add_index :daily_stats, :created_at, :order => { :created_at => :asc }
  end
end
