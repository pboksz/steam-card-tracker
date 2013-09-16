class Game < ActiveRecord::Base
  attr_accessible :name

  def query_name
    name.downcase.gsub(' ', '+')
  end
end
