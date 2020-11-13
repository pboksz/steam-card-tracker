require 'rails_helper'

describe Stat do
  let(:stat) { build(:stat) }

  describe 'default_scope' do
    describe 'order by created at' do
      let!(:stat1) { create(:stat, created_at: 1.day.ago) }
      let!(:stat2) { create(:stat, created_at: 2.days.ago) }

      it { expect(Stat.all).to eq [stat2, stat1] }
    end
  end

  describe '#data' do
    let(:milliseconds) { stat.created_at.to_i * 1000 }
    it { expect(stat.data).to eq x: milliseconds, low: stat.min_price_low, high: stat.min_price_high, total: stat.quantity }
  end
end
