require 'rails_helper'

describe StatsRepository do
  let(:repository) { StatsRepository.new(Stat) }

  describe '#update_prices_for_today' do
    let(:quantity) { 102 }
    subject { repository.update_prices_for_today(price, quantity) }

    describe 'no stat yet in the database' do
      let(:price) { 0.08 }

      it "creates" do
        expect(subject).to be_persisted
        expect(subject.min_price_low).to eq price
        expect(subject.min_price_high).to eq price
        expect(subject.quantity).to eq quantity
      end
    end

    describe 'stat in database' do
      let!(:stat) { create(:stat, min_price_low: 0.10, min_price_high: 0.20, quantity: 99) }

      describe 'price is lower than current low price' do
        let(:price) { 0.05 }

        it "updates" do
          expect(subject.min_price_low).to eq price
          expect(subject.min_price_high).to eq 0.20
          expect(subject.quantity).to eq 102
        end
      end

      describe 'price is higher than current high price' do
        let(:price) { 0.25 }

        it "updates" do
          expect(subject.min_price_low).to eq 0.10
          expect(subject.min_price_high).to eq price
          expect(subject.quantity).to eq 102
        end
      end

      describe 'price is between the low and high price' do
        let(:price) { 0.15 }

        it "updates" do
          expect(subject.min_price_low).to eq 0.10
          expect(subject.min_price_high).to eq 0.20
          expect(subject.quantity).to eq 102
        end
      end
    end
  end
end
