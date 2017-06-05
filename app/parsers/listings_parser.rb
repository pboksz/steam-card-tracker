class ListingsParser
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def parse
    if response_successful?
      listings.each { |listing| game_processor(listing_parser(listing)).process }
      games_repository.update(game.id)
    end
  end

  private

  def games_repository
    @games_repository ||= GamesRepository.new(Game)
  end

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
    @listings ||= Oga.parse_html(response['results_html']).css('.market_listing_row_link')
  end

  def listing_parser(listing)
    ListingParser.new(listing)
  end

  def game_processor(listing)
    GameProcessor.new(game, listing)
  end

  def response_successful?
    response['success'] && response['total_count'] > 0
  end
end
