require 'rails_helper'

RSpec.describe AuthenticationsController, type: :controller do
  describe '#login' do
    before do
      create(:user, email: 'user@example.com', password: 'password')
    end

    context 'when providing a valid email/password combination' do
      let(:login_params) { { email: 'user@example.com', password: 'password' } }

      it 'responds successfully' do
        post :login, params: { user: login_params }

        is_expected.to respond_with :ok
      end

      it 'returns the token, expiring date and user email' do
        post :login, params: { user: login_params }
        
        parsed_response = JSON.parse(response.body)

        expect(JSON.parse(response.body).keys).to include('token', 'exp', 'user_email')
      end
    end

    context 'when providing an invalid email/password combination' do
      let(:login_params) { { email: 'user@example.com', password: 'notmypassword' } }
      
      it 'responds successfully' do
        post :login, params: {user: login_params } 
        
        is_expected.to respond_with :unauthorized
      end
    end
  end
end
