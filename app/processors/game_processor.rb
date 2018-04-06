class GameProcessor
  attr_reader :game, :listing

  def initialize(game, listing)
    @game = game
    @listing = listing
  end

  def process
    item_processor.process unless listing.foil?
  end

  private

  def item_processor
    @item_processor ||= ItemProcessor.new(game.items, listing)
  end
end
