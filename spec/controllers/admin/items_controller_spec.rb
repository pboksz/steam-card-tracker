require 'rails_helper'

describe Admin::ItemsController do
  let(:repository) { double }
  before do
    allow(controller).to receive(:authenticate_admin!)
    allow(DefaultRepository).to receive(:new).with(Item).and_return(repository)
  end

  describe 'DELETE #destroy' do
    let(:params) { { game_id: '1', id: '1' } }
    before do
      expect(repository).to receive(:destroy).with(params[:id])
      delete :destroy, params
    end

    it { expect(response).to redirect_to admin_game_path('1') }
  end
end
