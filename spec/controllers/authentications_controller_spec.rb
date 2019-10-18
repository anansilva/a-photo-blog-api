require 'rails_helper'

RSpec.describe AuthenticationsController, type: :controller do
  describe '#login' do
    before do
      create(:user, email: 'user@example.com', password: 'password')
    end

    context 'when providing a valid email/password combination' do
      it 'responds successfully' do
        post :login, params: { email: 'user@example.com', password: 'password' }

        is_expected.to respond_with :ok
      end

      it 'returns the user' do
        post :login, params: { email: 'user@example.com', password: 'password' }
        
        parsed_response = JSON.parse(response.body)

        expect(JSON.parse(response.body)['id']).to eq(User.first.id)
      end
    end

    context 'when providing an invalid email/password combination' do
      it 'responds successfully' do
        post :login, params: { email: 'user@example.com', password: 'notmypassword' }
        
        is_expected.to respond_with :unauthorized
      end
    end
  end
end
