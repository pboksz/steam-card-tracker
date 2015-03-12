require 'rails_helper'

describe GameParser do
  let(:game) { build(:game) }
  let(:game_parser) { GameParser.new(game, listing) }

  describe '#parse' do
    describe 'game name not correct' do
      let(:listing) { double(game_name: "Invalid") }
      it { expect(game_parser.parse).to be_nil }
    end

    describe 'when is regular item from game' do
      let(:listing) { double(game_name: "#{game.name} Trading Card") }
      let(:item_parser) { double }
      before do
        allow(ItemParser).to receive(:new).with(game.items, listing).and_return(item_parser)
        expect(item_parser).to receive(:parse)
      end

      it { game_parser.parse }
    end
  end
end