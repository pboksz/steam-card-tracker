class Game < ActiveRecord::Base
  attr_accessible :name

  has_many :items

  def query_name
    name.downcase.gsub(' ', '+')
  end
end
