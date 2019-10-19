require 'rails_helper'

RSpec.describe ApplicationController do
  controller do
    def index
      render plain: :ok
    end
  end

  describe '#authorize_request' do
    let(:user) { create(:user) }

    context 'when token is valid and user exists' do
      it 'authorizes the user' do
        allow(Services::Authentications::JsonWebToken).to receive(:decode)
          .with('a_b123').and_return(user_id: user.id)

        request.headers[:HTTP_TOKEN] = 'a_b123'
        get :index

        is_expected.to respond_with :ok
      end
    end

    context 'when token is not valid' do
      it 'does not authorize the user' do
        allow(Services::Authentications::JsonWebToken).to receive(:decode)
          .with(nil).and_raise(JWT::DecodeError)

        get :index

        is_expected.to respond_with :unauthorized
      end
    end

    context 'when the user does not exist' do
      it 'does not authorize the user' do
        allow(Services::Authentications::JsonWebToken).to receive(:decode)
          .with('a_b123').and_return(user_id: 1001)

        request.headers[:HTTP_TOKEN] = 'a_b123'
        get :index

        is_expected.to respond_with :unauthorized
      end
    end
  end
end
