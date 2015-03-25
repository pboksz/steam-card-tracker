class GameProcessor
  attr_reader :game, :listing

  def initialize(game, listing)
    @game = game
    @listing = listing
  end

  def process
    if is_from_correct_game?
      item_processor.process
      games_repository.update(game.id)
    end
  end

  private

  def games_repository
    @games_repository ||= GamesRepository.new(Game)
  end

  def item_processor
    @item_processor ||= ItemProcessor.new(game.items, listing)
  end

  def is_from_correct_game?
    !!(listing.game_name =~ /^(#{Regexp.escape(game.name)}) (trading card)$/i)
  end
end
