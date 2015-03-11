require 'rails_helper'

describe ListingsRequester do
  let(:request) { double }
  let(:listing_requester) { ListingsRequester.new(request) }

  describe '#response' do
    let(:body) { double }
    let(:requester) { double(perform: double(body: body)) }
    let(:response) { double }
    before do
      allow(Weary::Request).to receive(:new).with(request).and_return(requester)
      expect(JSON).to receive(:parse).with(body).and_return(response)
    end

    it { expect(listing_requester.response).to eq response }
  end
end
