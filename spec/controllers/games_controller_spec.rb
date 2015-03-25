require 'rails_helper'

describe GamesController do
  let(:repository) { double }
  before { allow(DefaultRepository).to receive(:new).with(Game).and_return(repository) }

  describe 'GET #index' do
    let(:game) { double }
    let(:games) { double }
    before do
      expect(repository).to receive(:new).and_return(game)
      expect(repository).to receive(:all).and_return(games)
      get :index
    end

    it { expect(response).to render_template :index, locals: { game: game, games: games } }
  end

  describe 'POST #create' do
    let(:params) { { name: 'Game Name' } }
    before do
      expect(repository).to receive(:create).with(params)
      post :create, game: params
    end

    it { expect(response).to redirect_to games_path }
  end
end
