FactoryBot.define do
  factory :post do
    photo { File.open("#{::Rails.root}/spec/fixtures/ruby_PNG47.png") }
  end
end