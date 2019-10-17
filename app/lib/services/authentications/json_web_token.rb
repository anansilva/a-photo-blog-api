module Services
  module Authentications
    class JsonWebToken
      SECRET_KEY = Rails.application.secrets.secret_key_base
      
      def self.encode(payload)
        JWT.encode(payload, SECRET_KEY)
      end

      def self.decode(token)
        JWT.decode(token, SECRET_KEY).first
      end
    end
  end
end