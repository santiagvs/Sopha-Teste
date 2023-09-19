FactoryBot.define do
  factory :store do
    name { "Lojinha" }
    user_id { create(:user).id }
  end
end
