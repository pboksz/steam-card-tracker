class RequestGenerator
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def generate
    "#{url}#{options}"
  end

  private

  def url
    "http://steamcommunity.com/market/search/render"
  end

  def options
    "?query=#{query}&start=0&count=5000"
  end

  def query
    "trading+card+#{game_query_name}"
  end

  def game_query_name
    game.name.downcase.gsub(' ', '+')
  end
end
