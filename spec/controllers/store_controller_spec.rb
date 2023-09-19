require 'rails_helper'

RSpec.describe StoresController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_attributes) { { name: 'Store Name', user_id: user.id } }
  let(:invalid_attributes) { { name: '' } }

  before do
    sign_in user # Assuming you have a method for signing in users in your tests
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new store' do
        expect {
          post :create, params: { store: valid_attributes }, format: :json
        }.to change(Store, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new store' do
        expect {
          post :create, params: { store: invalid_attributes }, format: :json
        }.not_to change(Store, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    let(:store) { create(:store, user: user) }

    context 'with valid parameters' do
      let(:new_attributes) { { name: 'New Store Name' } }

      it 'updates the requested store' do
        put :update, params: { id: store.to_param, store: new_attributes }, format: :json
        store.reload
        expect(store.name).to eq('New Store Name')
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) { { name: '' } }
      it 'does not update the requested store' do
        put :update, params: { id: store.to_param, store: invalid_attributes }, format: :json
        store.reload
        expect(store.name).not_to eq('')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:store) { create(:store, user: user) }

    it 'destroys the requested store' do
      expect {
        delete :destroy, params: { id: store.to_param }, format: :json
      }.to change(Store, :count).by(-1)
      expect(response).to have_http_status(:ok)
    end
  end
end
