require 'rails_helper'

describe  RequestGenerator do
  let(:game) { build(:game) }
  let(:request_generator) { RequestGenerator.new(game) }

  describe '#generate' do
    it { expect(request_generator.generate).to include 'http://steamcommunity.com/market/search/render' }
    it { expect(request_generator.generate).to include 'query=trading+card' }
    it { expect(request_generator.generate).to include game.name.downcase }
    it { expect(request_generator.generate).to include 'start=0&count=5000' }
  end
end
