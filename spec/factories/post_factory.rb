FactoryBot.define do
  factory :post do
    photo { Rack::Test::UploadedFile.new("#{::Rails.root}/spec/fixtures/ruby_PNG47.png", 'image/png') }
  end
end