class ListingParser
  attr_reader :listing_html

  def initialize(listing_html)
    @listing_html = listing_html
  end

  def parse
    {
      name: parse_game_name(listing_html),
      item: {
        name: parse_name(listing_html),
        link_url: parse_link_url(listing_html),
        image_url: parse_image_url(listing_html),
        price: parse_price(listing_html)
      }
    }
  end

  private

  def parse_game_name(listing_html)
    listing_html.css('.market_listing_row .market_listing_game_name').first.content
  end

  def parse_name(listing_html)
    listing_html.css('.market_listing_row .market_listing_item_name').first.content
  end

  def parse_price(listing_html)
    listing_html.css('.market_listing_row .market_table_value span').first.content.match(/\d+.\d{1,2}/).to_s.to_f
  end

  def parse_link_url(listing_html)
    listing_html.attributes['href'].value
  end

  def parse_image_url(listing_html)
    listing_html.css('.market_listing_row img').first.attributes['src'].value
  end
end
