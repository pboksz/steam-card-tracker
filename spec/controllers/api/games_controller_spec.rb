require 'rails_helper'

describe Api::GamesController do
  let(:repository) { double }
  before { allow(DefaultRepository).to receive(:new).with(Game).and_return(repository) }

  describe 'GET #index' do
    let(:games) { double }
    before do
      expect(repository).to receive(:all).and_return(games)
      expect(games).to receive(:as_json)
    end

    it { get :index }
  end

  describe 'GET #show' do
    let(:game) { create(:game) }
    before { expect(repository).to receive(:find).with(id: game.id).and_return(game) }

    describe 'renders success' do
      before do
        expect(game).to receive(:as_full_json)
        get :show, params: { id: game.id }
      end

      it { expect(response.status).to eq 200 }
    end

    describe 'throws error' do
      before do
        expect(game).to receive(:as_full_json).and_raise(StandardError)
        get :show, params: { id: game.id }
      end

      it { expect(response.status).to eq 422 }
    end
  end

  describe 'GET #parse' do
    let(:game) { create(:game) }
    let(:parser) { double }
    before do
      expect(repository).to receive(:find).with(id: game.id).and_return(game)
      allow(ListingsParser).to receive(:new).with(game).and_return(parser)
    end

    describe 'parses correctly' do
      before do
        expect(parser).to receive(:parse).and_return(game)
        expect(game).to receive(:as_json)
        get :parse, params: { id: game.id }
      end

      it { expect(response.status).to eq 200 }
    end

    describe 'throws error' do
      before do
        expect(parser).to receive(:parse).and_raise(StandardError)
        get :parse, params: { id: game.id }
      end

      it { expect(response.status).to eq 422 }
    end
  end
end
