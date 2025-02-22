module JwtAuthentication
  class AuthenticateJwtToken
    # extend ActiveSupport::Concern
    attr_reader :user_id, :expiration, :data

    class << self
      def encode(user_id, expiration = nil, data = {})
        expiration, data = data, expiration unless data.is_a?(Hash)

        data       ||= {}
        expiration ||= 24.hours.from_now

        payload = build_payload_for(user_id, data, expiration.to_i)

        JWT.encode payload, secret_key, algorithm
      end

      def decode(token)
        JWT.decode(token, secret_key, true, {
          :algorithm => algorithm,
        })[0]
      end


      private

      def build_payload_for(id, data, expiration)
        {
          :id  => id,
          :exp => expiration,
        }.merge(data)
      end

      def token_data_for(token)
        JWT.decode(token, secret_key, true, {
          :algorithm => algorithm,
        })[0]
      end

      def algorithm
        'HS256'
      end
  
      def secret_key
        ENV['SECRET_KEY_BASE'] ||= Rails.application.secret_key_base
      end
    end
  end
end