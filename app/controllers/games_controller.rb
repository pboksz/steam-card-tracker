class GamesController < ApplicationController
  def index
    render :index, locals: { game: games_repository.new, games: games_repository.all }
  end

  def create
    games_repository.create(game_params)
    redirect_to games_path
  end

  private

  def games_repository
    @games_repository ||= DefaultRepository.new(Game)
  end

  def game_params
    params.require(:game).permit(:name)
  end
end
