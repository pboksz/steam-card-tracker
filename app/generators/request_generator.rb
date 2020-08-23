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
    "norender=1&query=\"#{query}\""
  end

  def query
    CGI.escape("#{game.name} Trading Card")
  end
end
