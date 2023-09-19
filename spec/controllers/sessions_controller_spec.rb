require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user] # Add this line
  end
  let(:user) { create(:user) }

  describe 'POST #create' do
    it 'returns a successful response with valid credentials' do
      post :create, params: { user: { email: user.email, password: user.password } }
      expect(response).to be_successful
    end

    # it 'returns a JWT token in the response with valid credentials' do
    #   post :create, params: { user: { email: user.email, password: user.password } }
    #   expect(JSON.parse(response.body)).to have_key('jwt')
    # end

    it 'returns a 401 Unauthorized response with invalid credentials' do
      post :create, params: { user: { email: 'invalid_email@example.com', password: 'invalid_password' } }
      expect(response).to have_http_status(401)
    end
  end

  describe 'DELETE #destroy' do
    it 'logs out the user and returns a successful response when logged in' do
      sign_in user
      delete :destroy
      expect(response).to be_successful
    end
  end
end
