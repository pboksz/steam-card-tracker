require 'rails_helper'

describe GamesRepository do
  let(:game) { create(:game) }
  let(:repository) { GamesRepository.new(Game) }

  describe '#update' do
    subject { repository.update(game.id) }

    it { expect(subject).to be_persisted }
    it { expect(subject.price_per_badge).to be_zero }
  end
end
