class ItemProcessor
  attr_reader :items, :listing

  def initialize(items, listing)
    @items = items
    @listing = listing
  end

  def process
    item = items_repository.update_link_and_image(listing.item_name, listing.link_url, listing.image_url)
    stat_processor(item.stats).process
  end

  private

  def items_repository
    @items_repository ||= ItemsRepository.new(items)
  end

  def stat_processor(stats)
    StatProcessor.new(stats, listing)
  end
end
