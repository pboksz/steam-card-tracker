class Api::GamesController < ApplicationController
  def index
    render json: games_repository.all.as_json
  end

  def show
    render json: game.as_full_json, status: :ok
  rescue => e
    render json: e.message, status: :unprocessable_entity
  end

  def reload
    listings_parser(game).parse
    render json: game.as_json, status: :ok
  rescue => e
    render json: e.message, status: :unprocessable_entity
  end

  private

  def games_repository
    @games_repository ||= DefaultRepository.new(Game)
  end

  def game
    @game ||= games_repository.find(id: params[:id])
  end

  def listings_parser(game)
    ListingsParser.new(game)
  end
end
