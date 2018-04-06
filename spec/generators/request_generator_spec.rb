require 'rails_helper'

describe  RequestGenerator do
  let(:game) { build(:game, name: "Game ABZÛ") }
  let(:request_generator) { RequestGenerator.new(game) }

  describe '#generate' do
    it { expect(request_generator.generate).to eq "http://steamcommunity.com/market/search/render?norender=1&query=trading+card+Game+ABZ%C3%9B" }
  end
end
