require 'rails_helper'

describe ItemsRepository do
  let(:game) { create(:game) }
  let(:repository) { ItemsRepository.new(game.items) }

  describe '#update_link_and_image' do
    let(:name) { 'Name' }
    let(:link) { 'link' }
    let(:image) { 'image' }
    subject { repository.update_link_and_image(name, link, image) }

    it "updates" do
      expect(subject).to be_persisted
      expect(subject.name).to eq name
      expect(subject.link_url).to eq link
      expect(subject.image_url).to eq image
    end
  end
end
