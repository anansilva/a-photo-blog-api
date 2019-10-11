require 'rails_helper'

describe Api::V1::PostsController do
  describe 'POST #create' do
    it 'creates a post successfully' do
      photo_file = fixture_file_upload("#{::Rails.root}/spec/fixtures/ruby.png", 'image/png')

      post :create, params: { post: { photo: photo_file } }

      expect(response.status).to eq(200)
    end
  end
end
