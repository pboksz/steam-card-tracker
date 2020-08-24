require 'rails_helper'

describe 'ListingParser' do
  let(:listing) {
    {
      'sell_price' => 36,
      'asset_description' => {
        'name' => 'Trading Card',
        'appid' => 100,
        'market_hash_name' => '12345-Trading Card',
        'icon_url' => 'TRADING-CARD12345',
        'type' => 'Game™ Trading® Card'
      }
    }
  }
  let(:parser) { ListingParser.new(listing) }

  describe '#item_name' do
    it { expect(parser.item_name).to eq 'Trading Card' }
  end

  describe '#game_name' do
    it { expect(parser.game_name).to eq 'Game Trading Card' }
  end

  describe '#link_url' do
    it { expect(parser.link_url).to eq 'https://steamcommunity.com/market/listings/100/12345-Trading Card' }
  end

  describe '#image_url' do
    it { expect(parser.image_url).to eq 'https://community.cloudflare.steamstatic.com/economy/image/TRADING-CARD12345' }
  end

  describe '#price' do
    it { expect(parser.price).to eq 0.36 }
  end

  describe '#foil?' do
    describe 'not foil' do
      it { expect(parser.foil?).to be false }
    end

    describe 'foil' do
      let(:listing) { { 'asset_description' => { 'name' => 'Trading Card (Foil)' } } }
      it { expect(parser.foil?).to be true }
    end

    describe 'foil trading card' do
      let(:listing) { { 'asset_description' => { 'name' => 'Trading Card (Foil Trading Card)' } } }
      it { expect(parser.foil?).to be true }
    end
  end
end
