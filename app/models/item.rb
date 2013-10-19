class Item
  include Mongoid::Document
  include Mongoid::Timestamps::Created::Short
  include Serializable

  field :n, :as => :name, :type => String

  attr_accessor :current_price, :current_quantity, :link_url, :image_url

  belongs_to :game
  has_many :daily_stats, :dependent => :destroy

  def foil?
    name.include?('Foil')
  end

  def all_time_min_price_low
    daily_stats.min(:min_price_low)
  end

  def all_time_min_price_high
    daily_stats.max(:min_price_high)
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

  def serializable_hash(options = {})
    Hash[super(options).map { |key, value| [self.aliased_fields.invert[key] || key, value] }]
  end
end
