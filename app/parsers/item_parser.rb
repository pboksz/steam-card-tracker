class ItemParser
  attr_reader :items, :listing

  def initialize(items, listing)
    @items = items
    @listing = listing
  end

  def parse
    item = items_repository.update_link_and_image(listing.item_name, listing.link_url, listing.image_url)
    stat_parser(item.stats).parse
  end

  private

  def items_repository
    @items_repository ||= ItemsRepository.new(items)
  end

  def stat_parser(stats)
    StatParser.new(stats, listing)
  end
end
