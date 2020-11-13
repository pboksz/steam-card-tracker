require 'rails_helper'

describe ItemJsonGenerator do
  let(:item) { create(:item) }
  let(:generator) { ItemJsonGenerator.new(item) }

  describe '#generate' do
    let(:generated) {
      {
        name: item.name,
        link_url: item.link_url,
        image_url: item.image_url,
        latest_price: item.latest_price,
        latest_quantity: item.latest_quantity,
        all_time_min_price_low: item.all_time_min_price_low,
        all_time_min_price_high: item.all_time_min_price_high
      }
    }

    it { expect(generator.generate).to eq generated }
  end

  describe '#generate_data' do
    let(:generated) {
      {
        name: item.name,
        data: item.all_stats_data
      }
    }

    it { expect(generator.generate_data).to eq generated }
  end
end
