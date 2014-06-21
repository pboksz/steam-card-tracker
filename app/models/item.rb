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
