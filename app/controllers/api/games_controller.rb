class Api::GamesController < ApplicationController
  def index
    render json: games_repository.all.as_json
  end

  def show
    game = games_repository.find(id: params[:id])
    listings_parser(game).parse

    render json: game.as_full_json
  end

  private

  def games_repository
    @games_repository ||= DefaultRepository.new(Game)
  end

  def listings_parser(game)
    ListingsParser.new(game)
  end
end
