class Item < ActiveRecord::Base
  attr_accessible :name, :link_url, :image_url, :foil, :currency_symbol, :game

  has_many :daily_stats, :dependent => :destroy
  belongs_to :game

  def short_name
    name.gsub(/(\(Trading Card\)|\sTrading Card)/, '')
  end

  def current_price
    @current_price
  end

  def current_price=(price)
    @current_price = price
  end
end
