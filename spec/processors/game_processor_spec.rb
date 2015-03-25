require 'rails_helper'

describe GameProcessor do
  let(:game) { build(:game) }
  let(:game_processor) { GameProcessor.new(game, listing) }

  describe '#process' do
    describe 'game name not correct' do
      let(:listing) { double(game_name: "Invalid") }
      it { expect(game_processor.process).to be_nil }
    end

    describe 'when is regular item from game' do
      let(:listing) { double(game_name: "#{game.name} Trading Card") }
      let(:item_processor) { double }
      let(:games_repository) { double }
      before do
        allow(ItemProcessor).to receive(:new).with(game.items, listing).and_return(item_processor)
        allow(GamesRepository).to receive(:new).with(Game).and_return(games_repository)
        expect(item_processor).to receive(:process)
        expect(games_repository).to receive(:update).with(game.id)
      end

      it { game_processor.process }
    end
  end
end
