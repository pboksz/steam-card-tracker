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
    before { expect(repository).to receive(:find).with(id: game.id).and_return(game) }

    describe 'show' do
      before do
        expect(game).to receive(:as_full_json)
        get :show, id: game.id, reload: "false"
      end

      it { expect(response.status).to eq 200 }
    end

    describe 'reload' do
      let(:parser) { double }
      before { allow(ListingsParser).to receive(:new).with(game).and_return(parser) }

      describe 'listings parses correctly' do
        before do
          expect(parser).to receive(:parse).and_return(game)
          expect(game).to receive(:as_full_json)
          get :show, id: game.id, reload: "true"
        end

        it { expect(response.status).to eq 200 }
      end

      describe 'listing parse throws error' do
        before do
          expect(parser).to receive(:parse).and_raise(StandardError)
          get :show, id: game.id, reload: "true"
        end

        it { expect(response.status).to eq 422 }
      end
    end
  end
end
