require 'rails_helper'

describe ApplicationController do
  controller do
    def index
      render nothing: true
    end
  end

  describe '#after_login_path' do
    it { expect(controller.after_login_path).to eq admin_games_path }

  end

  describe '#after_logout_path' do
    it { expect(controller.after_logout_path).to eq root_path }
  end
end
