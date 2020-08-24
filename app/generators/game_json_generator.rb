class GameJsonGenerator
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def generate
    {
      id: game.id.to_s,
      name: game.name,
      price_per_badge: game.price_per_badge,
      updated_today: game.updated_today?
    }
  end

  def generate_full
    generate.merge(items: items_json, data: items_data_json)
  end

  private

  def items_json
    game.items.map { |item| item_json_generator(item).generate }
  end

  def items_data_json
    game.items.map { |item| item_json_generator(item).generate_data }
  end

  def item_json_generator(item)
    ItemJsonGenerator.new(item)
  end
end
