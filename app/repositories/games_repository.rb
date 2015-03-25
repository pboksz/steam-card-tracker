class GamesRepository < DefaultRepository
  def update(id)
    game = find(id: id)
    game.touch(:updated_at)

    game
  end
end
