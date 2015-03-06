class JsonGenerator
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def generate
    game_json
  end

  def generate_full
    game_full_json
  end

  private

  def game_json
    {
      id: game.id.to_s,
      name: game.name
    }
  end

  def game_full_json
    {
      id: game.id.to_s,
      name: game.name,
      items: items_as_json,
      data: items_as_data_json,
    }
  end

  def item_json(item)
    {
      name: item.name,
      link_url: item.link_url,
      image_url: item.image_url,
      latest_price: item.latest_price,
      all_time_min_price_low: item.all_time_min_price_low,
      all_time_min_price_high: item.all_time_min_price_high,
    }
  end

  def item_data_json(item)
    {
      name: item.name,
      data: item_data(item)
    }
  end

  def items_as_json
    game.items.map { |item| item_json(item) }
  end

  def items_as_data_json
    game.items.map { |item| item_data_json(item) }
  end

  def item_data(item)
    item.stats.map(&:data) if item
  end
end
