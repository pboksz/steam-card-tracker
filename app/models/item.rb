class Item
  include Mongoid::Document
  include Mongoid::Timestamps::Created::Short
  include Serializable

  field :n, :as => :name, :type => String
  field :l, :as => :link_url, :type => String
  field :i, :as => :image_url, :type => String

  belongs_to :game
  has_many :stats, :dependent => :destroy

  def latest_price
    stats.last.min_price_low
  end

  def all_time_min_price_low
    stats.min(:min_price_low)
  end

  def all_time_min_price_high
    stats.max(:min_price_high)
  end
end
