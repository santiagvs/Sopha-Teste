require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end
  let(:valid_user_attributes) do
    {
      name: 'John Doe',
      email: 'johndoe@example.com',
      password: 'password123',
      password_confirmation: 'password123'
    }
  end

  let(:invalid_user_attributes) do
    {
      name: '',
      email: 'invalid_email',
      password: 'password123',
      password_confirmation: 'password456'
    }
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new user' do
        expect do
          post :create, params: { user: valid_user_attributes }, format: :json
        end.to change(User, :count).by(1)
        expect(response).to have_http_status(:created)
      end

      it 'returns the user as JSON' do
        post :create, params: { user: valid_user_attributes }, format: :json
        expect(JSON.parse(response.body)).to have_key('id')
        expect(JSON.parse(response.body)).to have_key('email')
        expect(JSON.parse(response.body)).to have_key('name')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new user' do
        expect do
          post :create, params: { user: invalid_user_attributes }, format: :json
        end.not_to change(User, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns validation errors as JSON' do
        post :create, params: { user: invalid_user_attributes }, format: :json
        expect(JSON.parse(response.body)).to have_key('errors')
      end
    end
  end
end
