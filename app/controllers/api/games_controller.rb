class Api::GamesController < ApplicationController
  def index
    render :json => games_repository.all.as_json
  end

  def show
    game = games_repository.find(id: params[:id])
    games_service(game).process

    render :json => game.as_json
  end

  private

  def games_repository
    @games_repository ||= DefaultRepository.new(Game)
  end

  def games_service(game)
    GamesService.new(game)
  end
end
