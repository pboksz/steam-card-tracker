class Item
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :name, :type => String
  field :all_time_min_price_low, :type => Float, :default => 0
  field :all_time_min_price_high, :type => Float, :default => 0

  attr_accessor :current_price, :current_quantity, :link_url, :image_url

  belongs_to :game
  has_many :daily_stats, :dependent => :destroy

  def foil?
    name.include?('Foil')
  end

  def series_data
    { :name => name, :data => daily_stats.map { |stat| [stat.min_price_low, stat.min_price_high] } }
  end

  def update_daily_stats
    daily_stats.where(:created_at => Time.now.beginning_of_day..Time.now.end_of_day).first_or_initialize.tap do |stats|
      stats.min_price_low = current_price if current_price < stats.min_price_low || stats.min_price_low == 0
      stats.min_price_high = current_price if current_price > stats.min_price_high
      stats.save if stats.changed?
    end
  end
end
