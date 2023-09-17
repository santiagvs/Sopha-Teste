FactoryBot.define do
  factory :user do
    name { "Pedro Silva" }
    email { "pedro@pedro.com" }
    password { "sifjjaf" }
  end

  factory :pseudo_user, class: 'User' do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(max_length: 8) }
  end
end
