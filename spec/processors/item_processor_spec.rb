require 'rails_helper'

describe ItemProcessor do
  let(:item) { build(:item) }
  let(:items) { [item] }
  let(:listing) { double(item_name: 'Card', link_url: '/link', image_url: '/image') }
  let(:item_processor) { ItemProcessor.new(items, listing) }

  describe '#process' do
    let(:repository) { double }
    let(:stat_processor) { double }

    before do
      allow(ItemsRepository).to receive(:new).with(items).and_return(repository)
      expect(repository).to receive(:update_link_and_image).with(listing.item_name, listing.link_url, listing.image_url).and_return(item)
      allow(StatProcessor).to receive(:new).with(item.stats, listing).and_return(stat_processor)
      expect(stat_processor).to receive(:process)
    end

    it { item_processor.process }
  end
end
