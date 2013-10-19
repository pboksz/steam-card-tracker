class Game
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  field :name, :type => String

  has_many :items, :dependent => :destroy

  def query_name
    name.downcase.gsub(' ', '+')
  end

  def series_dates(options = { :foil => false })
    items.select{ |item| item.foil? == options[:foil] }.first.daily_stats.map(&:humanize_date)
  end

  def series_data(options = { :foil => false })
    items.select{ |item| item.foil? == options[:foil] }.map(&:series_data)
  end

  # pass id to json for angular
  def serializable_hash(options={})
    {
      id: id.to_s,
      name: name
    }
  end
end
