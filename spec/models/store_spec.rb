require 'rails_helper'

RSpec.describe Store, type: :model do
  context "when the creation of a Store is successful" do
    it 'checks if a store is created' do
      store = FactoryBot.build(:store)
      expect(store).to be_valid
    end
  end
end
