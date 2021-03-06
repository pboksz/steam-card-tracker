class Stat
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  field :l, as: :min_price_low, type: Float, default: 0
  field :h, as: :min_price_high, type: Float, default: 0
  field :q, as: :quantity, type: Integer, default: 0

  belongs_to :item

  default_scope -> { order_by(created_at: :asc) }

  def data
    [created_at_in_milliseconds, min_price_low, min_price_high, quantity]
  end

  private

  def created_at_in_milliseconds
    created_at.to_i * 1000
  end
end
