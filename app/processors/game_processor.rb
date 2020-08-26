class GameProcessor
  attr_reader :game, :listing

  def initialize(game, listing)
    @game = game
    @listing = listing
  end

  def process
    item_processor.process if processable?
  end

  private

  def item_processor
    @item_processor ||= ItemProcessor.new(game.items, listing)
  end

  def processable?
    listing.game_name.starts_with?(game.name) && !listing.foil?
  end
end
