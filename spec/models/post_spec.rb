require 'rails_helper'
require 'pry'
RSpec.describe Post, type: :model do
  it { should belong_to(:user) }

  describe '#photo' do
    let(:post) { build(:post) }

    it { expect(post.photo).to be_an_instance_of(ActiveStorage::Attached::One) }
  end

  describe '#correct_image_mime_type' do
    it 'raises a validation error' do
      post = Post.new(photo: Rack::Test::UploadedFile.new("#{::Rails.root}/spec/fixtures/cv.pdf", 'image/png'))
      expect(post.save).to eq(false)
    end
  end
end
