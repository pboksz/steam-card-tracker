require 'rails_helper'

describe GameProcessor do
  let(:game) { build(:game) }
  let(:game_processor) { GameProcessor.new(game, listing) }

  describe '#process' do
    describe 'game name not correct' do
      let(:listing) { double(game_name: "Invalid") }
      it { expect(game_processor.process).to be_nil }
    end

    describe 'game name is correct' do
      let(:listing) { double(game_name: "#{game.name} Trading Card") }
      let(:item_processor) { double }
      before do
        allow(ItemProcessor).to receive(:new).with(game.items, listing).and_return(item_processor)
        expect(item_processor).to receive(:process)
      end

      it { game_processor.process }
    end
  end
end
