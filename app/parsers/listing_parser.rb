class ListingParser
  attr_reader :listing

  def initialize(listing)
    @listing = listing
  end

  def game_name
    listing.css('.market_listing_row .market_listing_game_name').first.content
  end

  def item_name
    listing.css('.market_listing_row .market_listing_item_name').first.content
  end

  def link_url
    listing.attributes['href'].value
  end

  def image_url
    listing.css('.market_listing_row img').first.attributes['src'].value
  end

  def price
    listing.css('.market_listing_row .market_table_value span').first.content.match(/\d+.\d{1,2}/).to_s.to_f
  end
end
