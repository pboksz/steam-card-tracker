require 'rails_helper'

describe HomeController do
  describe 'GET #index' do
    before { get :index }
    it { expect(response).to render_template :index }
  end

  describe 'GET #sitemap' do
    before { get :sitemap, format: 'xml' }
    it { expect(response).to render_template :sitemap, layout: false }
  end
end
