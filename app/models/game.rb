class Game
  include Mongoid::Document
  include Mongoid::Timestamps::Created::Short
  include Serializable

  field :n, :as => :name, :type => String

  has_many :items, :dependent => :destroy

  validates :name, :uniqueness => true

  default_scope -> { order_by(:name => :asc) }

  def as_json(options = {})
    {
      :id => id.to_s,
      :name => name,
      :regular_items => series_items(:foil => false),
      :regular_dates => series_dates(:foil => false),
      :regular_data => series_data(:foil => false),
      :foil_items => series_items(:foil => true),
      :foil_dates => series_dates(:foil => true),
      :foil_data => series_data(:foil => true)
    }
  end

  private

  def series_items(options = { :foil => false })
    items.select { |item| item.foil? == options[:foil] }.as_json
  end

  def series_dates(options = { :foil => false })
    items.select{ |item| item.foil? == options[:foil] }.first.stats.map(&:humanize_date)
  end

  def series_data(options = { :foil => false })
    items.select{ |item| item.foil? == options[:foil] }.map(&:series_data)
  end
end
