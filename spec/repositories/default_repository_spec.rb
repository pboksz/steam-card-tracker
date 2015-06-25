require 'rails_helper'

describe DefaultRepository do
  let(:new_name) { 'New name' }
  let(:repository) { DefaultRepository.new(Game) }

  describe '#all' do
    let!(:game) { create(:game) }
    it { expect(repository.all).to eq Game.all }
  end

  describe '#new' do
    describe 'no attributes' do
      it { expect(repository.new).to be_a Game }
    end

    describe 'with attributes' do
      it { expect(repository.new(name: new_name).name).to eq new_name }
    end
  end

  describe '#create' do
    describe 'valid attributes' do
      it { expect { repository.create(attributes_for(:game)) }.to change { Game.count }.by(1) }
    end
  end

  describe '#find_all' do
    describe 'exists in db' do
      let!(:game) { create(:game) }
      it { expect(repository.find_all(name: game.name)).to eq [game] }
    end

    describe 'does not exist in db' do
      it { expect(repository.find_all(name: 'invalid')).to be_empty }
    end
  end

  describe '#find' do
    describe 'exists in db' do
      let!(:game) { create(:game) }
      it { expect(repository.find(id: game.id)).to eq game }
    end

    describe 'does not exist in db' do
      it { expect(repository.find(id: 1234)).to be_nil }
    end
  end

  describe '#find_or_initialize' do
    describe 'exists in db' do
      let!(:game) { create(:game) }
      it { expect(repository.find_or_initialize(id: game.id)).to eq game }
    end

    describe 'does not exist in db' do
      it { expect(repository.find_or_initialize(id: 1234)).to be_a Game }
    end
  end

  describe '#destroy' do
    let!(:game) { create(:game) }
    it { expect{ repository.destroy(game.id) }.to change{ Game.count }.by(-1) }
  end
end
