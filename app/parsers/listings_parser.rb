class ListingsParser
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def parse
    listings.each { |listing| game_parser(listing_parser(listing)).parse } if response_successful?
  end

  private

  def request_generator
    @request_generator ||= RequestGenerator.new(game)
  end

  def listings_requester
    @listings_requester ||= ListingsRequester.new(request_generator.generate)
  end

  def response
    @response ||= listings_requester.response
  end

  def listings
    @listings ||= Nokogiri::HTML(response['results_html']).css('.market_listing_row_link')
  end

  def listing_parser(listing)
    ListingParser.new(listing)
  end

  def game_parser(listing)
    GameParser.new(game, listing)
  end

  def response_successful?
    response['success'] && response['total_count'] > 0
  end
end
