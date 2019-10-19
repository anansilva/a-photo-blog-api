require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe 'POST #create' do
    context 'when creating with valid email and password' do
      it 'creates a new user successfully' do
        user_params = {
          email: 'user@useremail.com',
          password: '123abc',
          password_confirmation: '123abc'
        }

        post :create, params: { user: user_params }

        is_expected.to respond_with :ok
      end
    end

    context 'when trying to create with an invalid email' do
      user_params = {
        email: 'user',
        password: '123abc',
        password_confirmation: '123abc'
      }

      it 'does not create the user' do
        post :create, params: { user: user_params }

        is_expected.to respond_with :unprocessable_entity
      end
    end

    context 'when trying to create with unmatching password and confirmation password' do
      user_params = {
        email: 'user@useremail.com',
        password: '123abc',
        password_confirmation: '124abc'
      }

      it 'does not create the user' do
        post :create, params: { user: user_params }

        is_expected.to respond_with :unprocessable_entity
      end
    end
  end
end
