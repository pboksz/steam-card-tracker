class ListingParser
  PRICE_REGEX = /\d+\.\d{1,2}/

  attr_reader :listing

  def initialize(listing)
    @listing = listing
  end

  def game_name
    listing.css('.market_listing_game_name').first.text
  end

  def item_name
    listing.css('.market_listing_item_name').first.text
  end

  def link_url
    listing.attribute('href').value
  end

  def image_url
    listing.css('img').first.attribute('src').value
  end

  def price
    full_price = listing.css('.market_table_value .normal_price').text
    full_price.match(PRICE_REGEX)[0].to_f
  end
end
