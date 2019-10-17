require 'rails_helper'

RSpec.describe ::Services::Authentications::JsonWebToken do
  describe '.encode' do
    it 'encodes a payload to a JWT token' do
      payload = { user_id: 1 }
      secret = 'adas123'
      
      result = described_class.encode(payload, secret)

      expect(result).to be_a(String)
    end
  end

  describe '.decode' do
    it 'decodes a JWT token' do
      token = "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.JqKuSBiVaI40iCw6BO-fPWhDomMAH0FGRN4FtoBt_cU"
      result = described_class.decode(token)

      expect(result).to eq({'user_id' => 1})
    end
  end
end
