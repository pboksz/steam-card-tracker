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
    "http://steamcommunity.com/market/search/render"
  end

  def options
    { query: "trading card #{game.name}", norender: 1 }.to_query
  end
end
