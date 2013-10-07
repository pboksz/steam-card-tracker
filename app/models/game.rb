class Game < ActiveRecord::Base
  attr_accessible :name

  has_many :items, :dependent => :destroy

  def query_name
    name.downcase.gsub(' ', '+')
  end

  def series_dates
    items.first.daily_stats.order(:created_at).map(&:humanize_date)
  end

  def series_data
    items.map(&:series_data)
  end
end
