require 'rails_helper'

describe Api::V1::PostsController do
  let(:user) { create(:user) }
  let(:photo_file) do
    fixture_file_upload("#{::Rails.root}/spec/fixtures/ruby.png", 'image/png')
  end

  describe 'POST #create' do
    context 'when user is signed in' do
      it 'creates a post successfully' do
        allow(controller).to receive(:authorize_request).and_return(true)
        allow(controller).to receive(:current_user) { user }

        post :create, params: { post: { photo: photo_file } }

        is_expected.to respond_with :success
      end
    end

    context 'when user is not signed in' do
      it 'does not authorize post creation' do
        post :create, params: { post: { photo: photo_file } }

        is_expected.to respond_with :unauthorized
      end
    end
  end

  describe 'GET #index' do
    context 'when user is signed in' do
      before 'sign in user, create posts and request index' do
        allow(controller).to receive(:authorize_request).and_return(true)
        allow(controller).to receive(:current_user) { user }

        create_list(:post, 3, user_id: user.id)

        get :index
      end

      it { is_expected.to respond_with :success }

      it 'renders all 3 posts' do
        expect(JSON.parse(response.body).size).to eq(3)
      end

      it 'serializes all post attributes' do
        posts_json = JSON.parse(response.body)
        attributes = %w[id created_at updated_at photo_thumbnail_url]

        expect(posts_json.first.keys).to match_array(attributes)
        expect(posts_json.first['photo_thumbnail_url'])
          .to include('/rails/active_storage/representations')
      end
    end

    context 'when user is not signed in' do
      before { get :index }

      it { is_expected.to respond_with :unauthorized }
    end
  end

  describe 'DELETE #destroy' do
    context 'when user is signed in' do
      before 'create 3 posts and sign in user' do
        create_list(:post, 3, user_id: user.id)
        allow(controller).to receive(:authorize_request).and_return(true)
        allow(controller).to receive(:current_user) { user }

        delete :destroy, params: { id: Post.last.id }
      end

      it { is_expected.to respond_with :success }

      it 'decreases the number of Posts by one' do
        expect(Post.count).to eq(2)
      end
    end

    context 'when user is not signed in' do
      before do
        create(:post, user_id: user.id)
        delete :destroy, params: { id: Post.last.id }
      end

      it { is_expected.to respond_with :unauthorized }
    end
  end
end
