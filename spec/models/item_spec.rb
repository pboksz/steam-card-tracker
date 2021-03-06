require 'rails_helper'

describe Item do
  let(:item) { build(:item) }
  let!(:stat1) { create(:stat, item: item, min_price_low: 0.10, min_price_high: 0.20, quantity: 99,  created_at: 2.days.ago) }
  let!(:stat2) { create(:stat, item: item, min_price_low: 0.12, min_price_high: 0.22, quantity: 102, created_at: 1.days.ago) }

  describe '#latest_price' do
    it { expect(item.latest_price).to eq stat2.min_price_low }
  end

  describe '#latest_quantity' do
    it { expect(item.latest_quantity).to eq stat2.quantity }
  end

  describe '#all_time_min_price_low' do
    it { expect(item.all_time_min_price_low).to eq stat1.min_price_low }
  end

  describe '#all_time_min_price_high' do
    it { expect(item.all_time_min_price_high).to eq stat2.min_price_high }
  end

  describe '#all_stats_data' do
    it { expect(item.all_stats_data).to eq [stat1.data, stat2.data] }
  end
end
