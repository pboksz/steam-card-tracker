class GameProcessor
  attr_reader :game, :listing

  def initialize(game, listing)
    @game = game
    @listing = listing
  end

  def process
    item_processor.process if is_from_correct_game?
  end

  private

  def item_processor
    @item_processor ||= ItemProcessor.new(game.items, listing)
  end

  def is_from_correct_game?
    !!(listing.game_name =~ /^(#{Regexp.escape(game.name)})\s+(trading card)$/i)
  end
end
