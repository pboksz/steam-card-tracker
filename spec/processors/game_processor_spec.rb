require 'rails_helper'

describe GameProcessor do
  let(:game) { build(:game, name: 'Game') }
  let(:game_processor) { GameProcessor.new(game, listing) }

  describe '#process' do
    describe 'not available' do
      let(:listing) { double(game_name: 'Game Trading Card', available?: false, foil?: false) }
      it { expect(game_processor.process).to be nil }
    end

    describe 'foil' do
      let(:listing) { double(game_name: 'Game Trading Card', available?: true, foil?: true) }
      it { expect(game_processor.process).to be nil }
    end

    describe 'wrong game' do
      let(:listing) { double(game_name: 'Other Trading Card', available?: true, foil?: false) }
      it { expect(game_processor.process).to be nil }
    end

    describe 'game name is correct' do
      let(:listing) { double(game_name: 'Game   Trading Card', available?: true, foil?: false) }
      let(:item_processor) { double }
      before do
        allow(ItemProcessor).to receive(:new).with(game.items, listing).and_return(item_processor)
        expect(item_processor).to receive(:process)
      end

      it { game_processor.process }
    end
  end
end
