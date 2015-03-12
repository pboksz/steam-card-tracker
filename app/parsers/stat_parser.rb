class StatParser
  attr_reader :stats, :listing

  def initialize(stats, listing)
    @stats = stats
    @listing = listing
  end

  def parse
    stats_repository.update_prices_for_today(parse_price)
  end

  private

  def stats_repository
    @stats_repository ||= StatsRepository.new(stats)
  end

  def parse_price
    listing.css('.market_listing_row .market_table_value span').first.content.match(/\d+.\d{1,2}/).to_s.to_f
  end
end
