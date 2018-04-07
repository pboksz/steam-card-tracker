class RequestGenerator
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def generate
    "#{url}?#{options}"
  end

  private

  def url
    "https://steamcommunity.com/market/search/render"
  end

  def options
    { query: "#{game.name} Trading Card", norender: 1 }.to_query
  end
end
