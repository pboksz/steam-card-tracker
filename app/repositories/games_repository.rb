class GamesRepository < DefaultRepository
  def update(id)
    game = find(id: id)
    game.update_attributes(price_per_badge: game.items.sum(&:latest_price))

    game
  end
end
