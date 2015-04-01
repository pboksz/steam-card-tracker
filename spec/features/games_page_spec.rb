require 'rails_helper'

describe 'Games page' do
  before { page.driver.block_unknown_urls }

  describe 'user visits add game page' do
    before do
      visit root_path
      find('.add-game').click
    end

    it { expect(page).to have_text 'Add a new game' }
    it { expect(page).to have_text 'Already in the database' }
  end

  describe 'user creates a new game' do
    let(:new_game_name) { 'New Game' }
    before do
      visit games_path
      find('#game_name').set(new_game_name)
      click_button 'Save'
    end

    it { expect(page).to have_text new_game_name }
  end
end
