class Admin::GamesController < ApplicationController
  before_action :authenticate_admin!

  def index
    render :index, locals: { game: games_repository.new, games: games_repository.all }
  end

  def create
    if games_repository.find(game_params).blank?
      games_repository.create(game_params)
      flash[:success] = "#{game_params[:name]} has been created"
    else
      flash[:warning] = "#{game_params[:name]} is already in the database"
    end

    redirect_to admin_games_path
  end

  def update
    if game&.update_attributes(game_params)
      flash[:success] = "#{game_params[:name]} has been updated"
    else
      flash[:warning] = "#{game_params[:name]} has NOT been updated"
    end

    redirect_to admin_games_path
  end

  private

  def games_repository
    @games_repository ||= DefaultRepository.new(Game)
  end

  def game
    @game ||= games_repository.find(id: params[:id])
  end

  def game_params
    params.require(:game).permit(:name)
  end
end
