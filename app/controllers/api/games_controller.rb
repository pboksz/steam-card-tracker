class Api::GamesController < ApplicationController
  def index
    render json: games_repository.all.as_json
  end

  def show
    game = games_repository.find(id: params[:id])

    if params[:reload] == "true"
      updated_game = listings_parser(game).parse
      render json: updated_game.as_full_json, status: :ok
    else
      render json: game.as_full_json, status: :ok
    end
  rescue => e
    render json: e.message, status: :unprocessable_entity
  end

  private

  def games_repository
    @games_repository ||= DefaultRepository.new(Game)
  end

  def listings_parser(game)
    ListingsParser.new(game)
  end
end
