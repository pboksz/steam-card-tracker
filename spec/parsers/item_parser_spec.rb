require 'rails_helper'

describe ItemParser do
  let(:item) { build(:item) }
  let(:items) { [item] }
  let(:listing) { TestListing.new }
  let(:item_parser) { ItemParser.new(items, listing) }

  describe '#parse' do
    let(:repository) { double }
    let(:stats_parser) { double }

    before do
      allow(ItemsRepository).to receive(:new).with(items).and_return(repository)
      expect(repository).to receive(:update_link_and_image).with('Trading Card', '/link', 'image.jpg').and_return(item)
      allow(StatsParser).to receive(:new).with(item.stats, listing).and_return(stats_parser)
      expect(stats_parser).to receive(:parse)
    end

    it { item_parser.parse }
  end
end
