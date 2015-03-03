class ItemParser
  attr_reader :items, :listing

  def initialize(items, listing)
    @items = items
    @listing = listing
  end

  def parse
    item = items_repository.update_link_and_image(parse_item_name, parse_link_url, parse_image_url)
    stats_parser(item.stats).parse
  end

  private

  def items_repository
    @items_repository ||= ItemsRepository.new(items)
  end

  def stats_parser(stats)
    StatsParser.new(stats, listing)
  end

  def parse_item_name
    listing.css('.market_listing_row .market_listing_item_name').first.content
  end

  def parse_link_url
    listing.attributes['href'].value
  end

  def parse_image_url
    listing.css('.market_listing_row img').first.attributes['src'].value
  end
end
