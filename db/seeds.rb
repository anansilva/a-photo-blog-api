# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
ruby_photo_file = Rack::Test::UploadedFile.new("#{::Rails.root}/spec/fixtures/ruby.png", 'image/png')
rails_photo_file = Rack::Test::UploadedFile.new("#{::Rails.root}/spec/fixtures/rails.png", 'image/png')

user = User.create(email: 'user@test.com', password: 'test')

Post.create(photo: ruby_photo_file, user_id: user.id)
Post.create(photo: rails_photo_file, user_id: user.id)
