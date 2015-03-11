require 'rails_helper'

describe JsonGenerator do
  let(:game) { create(:game) }
  let(:generator) { JsonGenerator.new(game) }

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
    let(:items) { double }
    let(:data) { double }
    before do
      expect(generator).to receive(:items_as_json).and_return(items)
      expect(generator).to receive(:items_as_data_json).and_return(data)
    end
    let(:generated) {
      {
        id: game.id.to_s,
        name: game.name,
        items: items,
        data: data
      }
    }

    it { expect(generator.generate_full).to eq generated }
  end
end
