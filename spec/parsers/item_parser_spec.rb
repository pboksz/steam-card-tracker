require 'rails_helper'

describe ItemParser do
  let(:item) { build(:item) }
  let(:items) { [item] }
  let(:listing) { double(item_name: 'Card', link_url: '/link', image_url: '/image') }
  let(:item_parser) { ItemParser.new(items, listing) }

  describe '#parse' do
    let(:repository) { double }
    let(:stat_parser) { double }

    before do
      allow(ItemsRepository).to receive(:new).with(items).and_return(repository)
      expect(repository).to receive(:update_link_and_image).with(listing.item_name, listing.link_url, listing.image_url).and_return(item)
      allow(StatParser).to receive(:new).with(item.stats, listing).and_return(stat_parser)
      expect(stat_parser).to receive(:parse)
    end

    it { item_parser.parse }
  end
end
