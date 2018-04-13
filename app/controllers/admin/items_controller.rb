class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    items_repository.destroy(params[:id])
    redirect_to admin_game_path(params[:game_id])
  end

  private

  def items_repository
    @items_repository ||= DefaultRepository.new(Item)
  end
end
