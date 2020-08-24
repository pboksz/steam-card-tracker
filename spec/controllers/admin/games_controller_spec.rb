require 'rails_helper'

describe Admin::GamesController do
  let(:repository) { double }
  before do
    allow(controller).to receive(:authenticate_admin!)
    allow(DefaultRepository).to receive(:new).with(Game).and_return(repository)
  end

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

    describe 'not present' do
      before do
        expect(repository).to receive(:find).with(params).and_return(nil)
        expect(repository).to receive(:create).with(params)
        post :create, game: params
      end

      it { expect(response).to redirect_to admin_games_path }
    end

    describe 'already present' do
      let(:game_in_database) { double }
      before do
        expect(repository).to receive(:find).with(params).and_return(game_in_database)
        expect(repository).to receive(:create).with(params).never
        post :create, game: params
      end

      it { expect(response).to redirect_to admin_games_path }
    end
  end
end
