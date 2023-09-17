require 'rails_helper'

RSpec.describe User, type: :model do
  context "when the creation of an User is successful" do
    it 'checks if a user is created' do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end
  end
end
