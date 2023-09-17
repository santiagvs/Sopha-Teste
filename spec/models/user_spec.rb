require 'rails_helper'

RSpec.describe User, type: :model do
  context "when the creation of an User is successful" do
    it 'checks if a user is created' do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end
  end

  context "when the creation of an User fails" do
    it 'disallows creation without name' do
      user = FactoryBot.build(:user, name: nil)
      expect(user.save).to be_falsey
    end

    it 'disallows creation without email' do
      user = FactoryBot.build(:user, email: nil)
      expect(user.save).to be_falsey
    end

    it 'disallows creation with an email that already exists' do
      pseudo_user = create(:pseudo_user)
      duplicate_user = build(:user, email: pseudo_user.email)
      expect(duplicate_user.save).to be_falsey
    end
  end
end
