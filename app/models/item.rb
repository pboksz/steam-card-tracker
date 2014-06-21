class Item
  include Mongoid::Document
  include Mongoid::Timestamps::Created::Short
  include Serializable

  field :n, :as => :name, :type => String

  attr_accessor :link_url, :image_url

  belongs_to :game
  has_many :stats, :dependent => :destroy

  def foil?
    name.include?('Foil')
  end

  def latest_price
    stats.last.min_price_low
  end

  def all_time_min_price_low
    stats.min(:min_price_low)
  end

  def all_time_min_price_high
    stats.max(:min_price_high)
  end

  def series_data
    { :name => name, :data => stats.map { |stat| [stat.min_price_low, stat.min_price_high] } }
  end

  def update_todays_stats
    stats.where(:created_at => Time.now.beginning_of_day..Time.now.end_of_day).first_or_initialize.tap do |stat|
      stat.min_price_low = current_price if current_price < stat.min_price_low || stat.min_price_low == 0
      stat.min_price_high = current_price if current_price > stat.min_price_high || stat.min_price_high == 0
      stat.save if stat.changed?
    end
  end

  def as_json(options = {})
    {
      :name => name,
      :link_url => link_url,
      :image_url => image_url,
      :all_time_min_price_low => all_time_min_price_low,
      :latest_price => latest_price,
      :all_time_min_price_high => all_time_min_price_high
    }
  end
end
