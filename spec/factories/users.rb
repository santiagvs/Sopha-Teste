FactoryBot.define do
  factory :user do
    id { 1 }
    name { "John" }
    email { "john@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
