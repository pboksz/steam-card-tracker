require 'rails_helper'

describe ItemsRepository do
  let(:repository) { ItemsRepository.new(Item) }

  describe '#update_link_and_image' do
    let(:name) { 'Name' }
    let(:link) { 'link' }
    let(:image) { 'image' }
    subject { repository.update_link_and_image(name, link, image) }

    it { expect(subject).to be_persisted }
    it { expect(subject.name).to eq name }
    it { expect(subject.link_url).to eq link }
    it { expect(subject.image_url).to eq image }
  end
end
