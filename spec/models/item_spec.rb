require 'rails_helper'

describe Item do
  let(:item) { build(:item) }
  let!(:stat1) { create(:stat, item: item, min_price_low: 0.10, min_price_high: 0.20, created_at: 2.days.ago) }
  let!(:stat2) { create(:stat, item: item, min_price_low: 0.12, min_price_high: 0.22, created_at: 2.days.ago) }

  describe '#latest_price' do
    it { expect(item.latest_price).to eq stat2.min_price_low }
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

  describe '#has_stats_for_today?' do
    describe 'no stats for today' do
      it { expect(item.has_stats_for_today?).to eq false }
    end

    describe 'has stats for today' do
      let!(:stat3) { create(:stat, item: item, created_at: Date.today) }
      it { expect(item.has_stats_for_today?).to eq true }
    end
  end
end
