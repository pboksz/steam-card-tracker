require 'rails_helper'

describe 'ListingParser' do
  let(:parser) { ListingParser.new(TestListing.new) }

  describe '#game_name' do
    it { expect(parser.game_name).to eq 'Game Trading Card' }
  end

  describe '#item_name' do
    it { expect(parser.item_name).to eq 'Trading Card' }
  end

  describe '#link_url' do
    it { expect(parser.link_url).to eq '/link' }
  end

  describe '#image_url' do
    it { expect(parser.image_url).to eq 'image.jpg' }
  end

  describe '#price' do
    it { expect(parser.price).to eq 0.1 }
  end
end
