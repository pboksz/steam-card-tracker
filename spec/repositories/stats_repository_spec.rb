require 'rails_helper'

describe StatsRepository do
  let(:repository) { StatsRepository.new(Stat) }

  describe '#update_prices_for_today' do
    subject { repository.update_prices_for_today(price) }

    describe 'no stat yet in the database' do
      let(:price) { 0.08 }

      it { expect(subject).to be_persisted }
      it { expect(subject.min_price_low).to eq price }
      it { expect(subject.min_price_high).to eq price }
    end

    describe 'stat in database' do
      let!(:stat) { create(:stat, min_price_low: 0.10, min_price_high: 0.20) }

      describe 'price is lower than current low price' do
        let(:price) { 0.05 }
        it { expect(subject.min_price_low).to eq price }
        it { expect(subject.min_price_high).not_to eq price }
      end

      describe 'price is higher than current high price' do
        let(:price) { 0.25 }
        it { expect(subject.min_price_low).not_to eq price }
        it { expect(subject.min_price_high).to eq price }
      end

      describe 'price is between the low and high price' do
        let(:price) { 0.15 }
        it { expect(subject.min_price_low).not_to eq price}
        it { expect(subject.min_price_high).not_to eq price }
      end
    end
  end
end
