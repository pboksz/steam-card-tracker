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
      regular_items: items_as_json(regular_items),
      regular_dates: items_as_dates_json(regular_items),
      regular_data: items_as_data_json(regular_items),
      foil_items: items_as_json(foil_items),
      foil_dates: items_as_dates_json(foil_items),
      foil_data: items_as_data_json(foil_items)
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

  def item_chart_json(item)
    {
      name: item.name,
      data: item_data(item)
    }
  end

  def items_as_json(items)
    items.map { |item| item_json(item) }
  end

  def items_as_dates_json(items)
    item_dates(items.first) || []
  end

  def items_as_data_json(items)
    items.map { |item| item_chart_json(item) }
  end

  def item_dates(item)
    item.stats.map(&:date) if item
  end

  def item_data(item)
    item.stats.map(&:data) if item
  end

  def regular_items
    @regular_items ||= game.items.select { |item| item.regular? }
  end

  def foil_items
    @foil_items ||= game.items.select { |item| item.foil? }
  end
end
