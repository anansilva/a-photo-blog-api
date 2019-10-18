require 'rails_helper'

RSpec.describe ::Services::Authentications::JsonWebToken do
  describe '.encode' do
    it 'encodes a payload to a JWT token' do
      expiring_date = 24.hours.from_now
      payload = { user_id: 1, exp: expiring_date }
      secret = stub_const('::Services::Authentications::JsonWebToken::SECRET_KEY', '123abc')

      allow(JWT).to receive(:encode).with(payload, secret)
      
      result = described_class.encode(payload)

      expect(JWT).to have_received(:encode).with({user_id: 1, exp: expiring_date.to_i}, secret)
    end
  end

  describe '.decode' do
    it 'decodes a JWT token' do
      token = 'this.is.jot'
      secret = stub_const('::Services::Authentications::JsonWebToken::SECRET_KEY', '123abc')
      allow(JWT).to receive(:decode).with(token, secret).and_return([])

      result = described_class.decode(token)

      expect(JWT).to have_received(:decode).with(token, secret)
    end
  end
end
