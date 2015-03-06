class GameParser
  attr_reader :game, :listing

  def initialize(game, listing)
    @game = game
    @listing = listing
  end

  def parse
    item_parser.parse if is_regular_item_from_correct_game?
  end

  private

  def item_parser
    @item_parser ||= ItemParser.new(game.items, listing)
  end

  def is_regular_item_from_correct_game?
    !!(parse_game_name =~ /^(#{Regexp.escape(game.name)}) (trading card)$/i)
  end

  def parse_game_name
    listing.css('.market_listing_row .market_listing_game_name').first.content
  end
end
