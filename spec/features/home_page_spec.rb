require 'rails_helper'

describe 'Home page' do
  let!(:game1) { create(:game, name: 'Batman') }
  let!(:item1) { create(:item, game: game1) }
  let!(:stat1) { create(:stat, item: item1) }

  let!(:game2) { create(:game, name: 'Zombie') }
  let!(:item2) { create(:item, game: game2) }
  let!(:stat2) { create(:stat, item: item2) }

  before { visit root_path }

  describe 'can view games' do
    it 'has both games listed' do
      expect(page).to have_text game1.name
      expect(page).to have_text game2.name
    end
  end

  describe 'can filter games' do
    before { find('.search').set('Bat') }

    it 'shows only matching game' do
      expect(page).to have_text game1.name
      expect(page).not_to have_text game2.name
    end
  end

  describe 'click on game name' do
    let(:repository) { double }
    let(:parser) { double }
    before do
      allow(DefaultRepository).to receive(:new).with(Game).and_return(repository)
      allow(ListingsParser).to receive(:new).with(game1).and_return(parser)
      expect(repository).to receive(:find).with(id: game1.id).and_return(game1)
      expect(parser).to receive(:parse).and_return(result)
      first('.game .name').click
    end

    describe 'success' do
      let(:result) { game1 }

      it 'shows item stats and chart' do
        expect(first('.game')).to have_css '.game-title.success'
        expect(first('.game .time-to-load')).to have_text 'seconds'
        expect(first('.game .game-chart')).to have_css '.highcharts-container'
        expect(first('.game .game-title')).to have_css '.updated-today', visible: true

        expect(first('.game').first('.game-item .name')).to have_text item1.name
        expect(first('.game').first('.game-item .low')).to have_text stat1.min_price_low
        expect(first('.game').first('.game-item .current')).to have_text stat1.min_price_low
        expect(first('.game').first('.game-item .high')).to have_text stat1.min_price_high
      end

      it 'click to hide' do
        expect(first('.game')).to have_selector '.game-cards', visible: true
        first('.game .name').click
        expect(first('.game')).to have_selector '.game-cards', visible: false
      end
    end

    describe 'error' do
      let(:result) { nil }

      it 'shows warning and time' do
        expect(first('.game')).to have_css '.game-title.warning'
        expect(first('.game .time-to-load')).to have_text 'seconds'
      end
    end
  end
end
