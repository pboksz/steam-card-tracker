require 'rails_helper'

describe ListingsParser do
  let(:response) {
    {
      'success' => success,
      'total_count' => 1,
      'results' => { 'name' => 'Card' }
    }
  }
  let(:game) { build(:game) }
  let(:generator) { double(generate: double) }
  let(:requester) { double(response: response) }
  let(:listings_parser) { ListingsParser.new(game) }
  before do
    allow(RequestGenerator).to receive(:new).with(game).and_return(generator)
    allow(ListingsRequester).to receive(:new).with(generator.generate).and_return(requester)
  end

  describe '#parse' do
    describe 'response is not successful' do
      let(:success) { false }
      it { expect { listings_parser.parse }.to raise_error "no listings present" }
    end

    describe 'response is successful' do
      let(:success) { true }
      let(:listing) { double }
      let(:game_processor) { double }
      let(:games_repository) { double }
      before do
        allow(ListingParser).to receive(:new).and_return(listing)
        allow(GameProcessor).to receive(:new).with(game, listing).and_return(game_processor)
        allow(GamesRepository).to receive(:new).with(Game).and_return(games_repository)
        expect(game_processor).to receive(:process)
        expect(games_repository).to receive(:update).with(game.id).and_return(game)
      end

      it { expect(listings_parser.parse).to eq game }
    end
  end
end
