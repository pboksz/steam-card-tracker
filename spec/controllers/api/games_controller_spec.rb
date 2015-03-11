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
    let(:game) { build(:game) }
    let(:parser) { double }
    before do
      expect(repository).to receive(:find).with(id: game.id).and_return(game)
      allow(ListingsParser).to receive(:new).with(game).and_return(parser)
      expect(parser).to receive(:parse)
      expect(game).to receive(:as_full_json)
    end

    it { get :show, id: game.id }
  end
end
