class Item < ActiveRecord::Base
  attr_accessible :name, :link_url, :image_url, :foil, :game

  belongs_to :game

  def short_name
    name.gsub(/(\(Trading Card\)|\sTrading Card)/, '')
  end
end
