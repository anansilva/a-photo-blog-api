FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password_digest { 'mypassword' }
  end
end
