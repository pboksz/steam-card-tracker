require 'rails_helper'

describe GameJsonGenerator do
  let(:game) { create(:game) }
  let(:generator) { GameJsonGenerator.new(game) }

  describe '#generate' do
    let(:generated) {
      {
        id: game.id.to_s,
        name: game.name
      }
    }

    it { expect(generator.generate).to eq generated }
  end

  describe '#generate_full' do
    let!(:item) { create(:item, game: game) }
    let(:item_generator) { double }
    let(:item_json) { double }
    let(:data_json) { double }
    before do
      allow(ItemJsonGenerator).to receive(:new).with(item).and_return(item_generator)
      expect(item_generator).to receive(:generate).and_return(item_json)
      expect(item_generator).to receive(:generate_data).and_return(data_json)
    end
    let(:generated) {
      {
        id: game.id.to_s,
        name: game.name,
        items: [item_json],
        data: [data_json]
      }
    }

    it { expect(generator.generate_full).to eq generated }
  end
end
