require 'rails_helper'

RSpec.describe Store, type: :model do
  context "when the creation of a Store is successful" do
    it 'checks if a store is created' do
      store = create(:store)
      expect(store).to be_valid
    end
    it { should belong_to(:user) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:user_id) }
  end
end
