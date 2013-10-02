class Item < ActiveRecord::Base
  attr_accessible :name, :link_url, :image_url, :foil, :currency_symbol, :game
  attr_accessor :current_price, :current_quantity

  has_many :daily_stats, :dependent => :destroy
  belongs_to :game

  def short_name
    name.gsub(/(\(Trading Card\)|\sTrading Card)/, '').truncate(17)
  end

  def all_time_low_price
    daily_stats.minimum(:min_price_low_integer) / 100.00
  end

  def all_time_high_price
    daily_stats.maximum(:min_price_high_integer) / 100.00
  end
end
