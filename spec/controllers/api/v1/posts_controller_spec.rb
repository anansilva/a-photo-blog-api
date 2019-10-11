require 'rails_helper'

describe Api::V1::PostsController do
  describe 'POST #create' do
    it 'creates a post successfully' do
      photo_file = fixture_file_upload("#{::Rails.root}/spec/fixtures/ruby.png", 'image/png')

      post :create, params: { post: { photo: photo_file } }

      expect(response.status).to eq(200)
    end
  end

  describe 'GET #index' do
    before 'create 3 posts' do
      create_list(:post, 3)
    end
    
    it 'gets the posts successfully' do
      get :index 

      expect(response.status).to eq(200)
    end
    
    it 'renders all 3 posts' do 
      get :index 

      expect(JSON.parse(response.body).size).to eq(3)
    end

    it 'serializes all post attributes' do
      get :index

      posts_json = JSON.parse(response.body)
      expect(posts_json.first.keys).to match_array(['id', 'created_at', 'updated_at', 'photo'])
      expect(posts_json.first['photo']).to include('/rails/active_storage/blobs')
    end
  end
end
