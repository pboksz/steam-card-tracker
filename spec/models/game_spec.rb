require 'rails_helper'

describe Game do
  let(:game) { build(:game) }
  let(:json_generator) { double }
  before { allow(JsonGenerator).to receive(:new).with(game).and_return(json_generator) }

  describe 'validations' do
    it { expect(game).to be_valid }

    describe 'uniqueness' do
      let!(:saved_game) { create(:game) }
      it { expect(build(:game, name: saved_game.name)).not_to be_valid }
    end
  end

  describe 'default_scope' do
    describe 'order by name' do
      let!(:game1) { create(:game, name: 'b') }
      let!(:game2) { create(:game, name: 'a') }

      it { expect(Game.all).to eq [game2, game1] }
    end
  end

  describe '#as_json' do
    before { expect(json_generator).to receive(:generate) }
    it { game.as_json }
  end

  describe '#as_full_json' do
    before { expect(json_generator).to receive(:generate_full) }
    it { game.as_full_json }
  end
end
