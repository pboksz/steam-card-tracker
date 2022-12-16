require 'rails_helper'

describe Admin::GamesController do
  let(:repository) { DefaultRepository.new(Game) }
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
    let(:params) { { game: { name: 'Game Name' } } }

    describe 'not present' do
      before do
        expect(repository).to receive(:create)
        post :create, params: params
      end

      it do
        expect(response).to redirect_to admin_games_path
        expect(flash[:success]).to eq "Game Name has been created"
      end
    end

    describe 'already present' do
      let!(:game) { create(:game, name: 'Game Name') }
      before do
        expect(repository).to receive(:create).never
        post :create, params: params
      end

      it do
        expect(response).to redirect_to admin_games_path
        expect(flash[:warning]).to eq "Game Name is already in the database"
      end
    end
  end

  describe 'PUT #update' do
    let!(:game) { create(:game, name: 'Game Name') }
    let(:params) { { id: game.id, game: { name: 'Game Name' } } }

    describe 'valid params' do
      let(:params) { { id: game.id, game: { name: 'Game Name' } } }
      before { put :update, params: params }

      it do
        expect(response).to redirect_to admin_games_path
        expect(flash[:success]).to eq "Game Name has been updated"
      end
    end

    describe 'invalid params' do
      let(:params) { { id: 'invalid123', game: { name: 'Game Name' } } }
      before { put :update, params: params }

      it do
        expect(response).to redirect_to admin_games_path
        expect(flash[:warning]).to eq "Game Name has NOT been updated"
      end
    end
  end
end
