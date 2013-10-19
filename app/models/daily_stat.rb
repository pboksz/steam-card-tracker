class DailyStat
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :min_price_low, :type => Float, :default => 0
  field :min_price_high, :type => Float, :default => 0

  belongs_to :item

  default_scope order_by(:created_at => :asc)

  def humanize_date
    created_at.strftime('%-m/%-d')
  end
end
