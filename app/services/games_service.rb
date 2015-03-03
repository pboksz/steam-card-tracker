class GamesService
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def process
    if listings_parser.response_successful?
      listings_parser.parse.each { |attributes| process_attributes(attributes) }
    end
  end

  private

  def request_generator
    @request_generator ||= RequestGenerator.new(game)
  end

  def listing_requester
    @listing_requestor ||= ListingRequester.new(request_generator.generate)
  end

  def listings_parser
    @listings_parser ||= ListingsParser.new(listing_requester.response)
  end

  def items_repository
    @items_repository ||= ItemsRepository.new(game.items)
  end

  def stats_repository(item)
    StatsRepository.new(item.stats)
  end

  def card_from_correct_game?(game_name)
    !!(game_name =~ /#{Regexp.escape(game.name)}\s*(foil\s)?(trading card)/i)
  end

  def process_attributes(attributes)
    process_item(attributes[:item]) if card_from_correct_game?(attributes[:name])
  end

  def process_item(attributes)
    item = items_repository.update_link_and_image(attributes)
    stats_repository(item).update_prices_for_today(attributes[:price])
  end
end
