FactoryBot.define do
  factory :user do
    email { "user@example.com" }
    password_digest { "MyString" }
  end
end
