class ListingParser
  attr_reader :listing

  def initialize(listing)
    @listing = listing
  end

  def game_name
    listing_row.css('.market_listing_game_name').first.content
  end

  def item_name
    listing_row.css('.market_listing_item_name').first.content
  end

  def link_url
    listing.attributes['href'].value
  end

  def image_url
    listing_row.css('img').first.attributes['src'].value
  end

  def price
    contents = listing_row.css('.market_table_value span').map(&:content)
    content = contents.find { |c| c.match(/\$\d+\.\d{1,2}/) }
    content[1..-1].to_f
  end

  private

  def listing_row
    listing.css('.market_listing_row')
  end
end
