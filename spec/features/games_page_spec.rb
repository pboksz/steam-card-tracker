require 'rails_helper'

describe 'Games page' do
  describe 'user tries to visit admin pages' do
    before { visit admin_games_path }
    it { expect(page).to have_text 'Admin login' }
  end

  describe 'admin tries to visit admin pages' do
    let(:new_game_name) { 'New Game' }
    let(:password) { 'password' }
    let!(:admin) { create(:admin, password: password, password_confirmation: password) }
    before do
      visit admin_games_path
      find('#admin_email').set(admin.email)
      find('#admin_password').set(password)
      click_button 'Login'
    end

    it 'is on the correct page' do
      expect(page).to have_text 'Add a new game'
      expect(page).to have_text 'Already in the database'
    end

    it 'creates and destroys a game' do
      expect(page).not_to have_text new_game_name
      find('#game_name').set(new_game_name)
      click_button 'Save'
      expect(page).to have_text new_game_name
      find('.fa-trash-o').click
      expect(page).not_to have_text new_game_name
    end
  end
end
