class AddAllTimePricesToItem < ActiveRecord::Migration
  def change
    add_column :items, :all_time_high_price_integer, :integer, :default => 0
    add_column :items, :all_time_low_price_integer, :integer, :default => 0
  end
end
