class DailyStat < ActiveRecord::Base
  attr_accessible :min_price_low_integer, :min_price_high_integer, :quantity_low, :quantity_high, :item

  belongs_to :item

  delegate :currency_symbol, :to => :item

  def min_price_low
    min_price_low_integer / 100
  end

  def min_price_low=(price)
    self.min_price_low_integer = price * 100
  end

  def min_price_high
    min_price_high_integer / 100
  end

  def min_price_high=(price)
    self.min_price_high_integer = price * 100
  end
end
