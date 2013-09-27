class Item < ActiveRecord::Base
  attr_accessible :name, :link_url, :image_url, :foil, :currency_symbol, :game
  attr_accessor :current_price, :current_quantity

  has_many :daily_stats, :dependent => :destroy
  belongs_to :game

  def short_name
    name.gsub(/(\(Trading Card\)|\sTrading Card)/, '')
  end
end
