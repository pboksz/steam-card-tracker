require 'rails_helper'

describe StatProcessor do
  let(:stat) { build(:stat) }
  let(:stats) { [stat] }
  let(:listing) { double(price: 0.1) }
  let(:stat_processor) { StatProcessor.new(stats, listing) }

  describe '#process' do
    let(:repository) { double }

    before do
      allow(StatsRepository).to receive(:new).with(stats).and_return(repository)
      expect(repository).to receive(:update_prices_for_today).with(listing.price)
    end

    it { stat_processor.process }
  end
end
