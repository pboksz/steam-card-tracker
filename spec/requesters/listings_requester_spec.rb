require 'rails_helper'

describe ListingsRequester do
  let(:request) { double }
  let(:listing_requester) { ListingsRequester.new(request) }

  describe '#response' do
    let(:parser) { double }
    let(:body) { double }
    let(:requester) { double(perform: double(body: body)) }
    let(:response) { double }
    before do
      allow(listing_requester).to receive(:parser).and_return(parser)
      allow(listing_requester).to receive(:requester).and_return(requester)
      expect(parser).to receive(:parse).with(body).and_return(response)
    end

    it { expect(listing_requester.response).to eq response }
  end
end
