class ListingsParser
  attr_reader :response

  def initialize(response)
    @response = response
  end

  def response_successful?
    response['success'] && response['total_count'] > 0
  end

  def parse
    listings_html.each { |listing_html| listing_parser(listing_html).parse }
  end

  private

  def listings_html
    @listings_html ||= Nokogiri::HTML(response['results_html']).css('.market_listing_row_link')
  end

  def listing_parser(listing_html)
    ListingParser.new(listing_html)
  end
end
