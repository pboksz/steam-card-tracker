require 'rails_helper'

describe HomeController do
  describe 'GET #index' do
    before { get :index }
    it { expect(response).to render_template :index }
  end
end
