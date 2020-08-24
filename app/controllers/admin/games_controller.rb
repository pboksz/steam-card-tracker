class Admin::GamesController < ApplicationController
  before_action :authenticate_admin!

  def index
    render :index, locals: { game: games_repository.new, games: games_repository.all }
  end

  def create
    games_repository.create(game_params) unless games_repository.find(game_params).present?
    redirect_to admin_games_path
  end

  private

  def games_repository
    @games_repository ||= DefaultRepository.new(Game)
  end

  def game_params
    params.require(:game).permit(:name)
  end
end
