require 'rails_helper'

describe ListingsParser do
  let(:response) {
    {
      'success' => success,
      'total_count' => 1,
      'results_html' => '<div class="market_listing_row_link">Row</div>'
    }
  }
  let(:game) { build(:game) }
  let(:generator) { double(generate: double) }
  let(:requester) { double(response: response) }
  let(:listings_parser) { ListingsParser.new(game) }
  before do
    allow(RequestGenerator).to receive(:new).with(game).and_return(generator)
    allow(ListingsRequester).to receive(:new).with(generator.generate).and_return(requester)
  end

  describe '#parse' do
    describe 'response is not successful' do
      let(:success) { false }
      it { expect(listings_parser.parse).to be_nil }
    end

    describe 'response is successful' do
      let(:success) { true }
      let(:listing) { double }
      let(:game_parser) { double }
      before do
        allow(ListingParser).to receive(:new).and_return(listing)
        allow(GameParser).to receive(:new).with(game, listing).and_return(game_parser)
        expect(game_parser).to receive(:parse)
      end

      it { listings_parser.parse }
    end
  end
end
