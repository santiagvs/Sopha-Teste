FactoryBot.define do
  factory :jwt_blacklist do
    jti { "MyString" }
    exp { "2023-09-18 16:45:59" }
  end
end
