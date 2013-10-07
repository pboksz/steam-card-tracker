class Item < ActiveRecord::Base
  attr_accessible :name, :link_url, :image_url, :foil, :currency_symbol, :game
  attr_accessor :current_price, :current_quantity

  has_many :daily_stats, :dependent => :destroy
  belongs_to :game

  def short_name
    name.gsub(/(\(Trading Card\)|\sTrading Card)/, '').truncate(17)
  end

  def all_time_low_price
    daily_stats.minimum(:min_price_low_integer).try(:/, 100.00)
  end

  def all_time_high_price
    daily_stats.maximum(:min_price_high_integer).try(:/, 100.00)
  end

  def series_data
    { :name => short_name, :data => daily_stats.order(:created_at).map { |stat| [stat.min_price_low, stat.min_price_high] } }
  end

  def update_daily_stats
    daily_stats.where(:created_at => Time.now.beginning_of_day..Time.now.end_of_day).first_or_initialize.tap do |stats|
      stats.min_price_low = current_price if current_price < stats.min_price_low || stats.min_price_low == 0
      stats.min_price_high = current_price if current_price > stats.min_price_high
      stats.quantity_low = current_quantity if current_quantity < stats.quantity_low || stats.quantity_low == 0
      stats.quantity_high = current_quantity if current_quantity > stats.quantity_high
      stats.save if stats.changed?
    end
  end
end
