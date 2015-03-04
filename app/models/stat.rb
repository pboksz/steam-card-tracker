class Stat
  include Mongoid::Document
  include Mongoid::Timestamps::Created::Short
  include Serializable

  field :l, :as => :min_price_low, :type => Float, :default => 0
  field :h, :as => :min_price_high, :type => Float, :default => 0

  belongs_to :item

  default_scope -> { order_by(:created_at => :asc) }

  def date
    created_at.strftime('%-m/%-d/%y')
  end

  def data
    [min_price_low, min_price_high]
  end
end
