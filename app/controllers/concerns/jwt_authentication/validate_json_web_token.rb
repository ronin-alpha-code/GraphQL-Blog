module JwtAuthentication
  module ValidateJsonWebToken
    attr_reader :token, :decoded_token

    ERROR_CLASSES = [
      JWT::DecodeError,
      JWT::ExpiredSignature,
    ].freeze

    def validate_json_web_token(token)
      begin
        AuthenticateJwtToken.decode(token)
      rescue *ERROR_CLASSES => e
        handle_decode_exception(e)
      end
    end

    private
    
    def handle_decode_exception(exception)
      case exception
      when JWT::DecodeError
        raise GraphQL::ExecutionError, 'Invalid token'
      when JWT::ExpiredSignature
        raise GraphQL::ExecutionError, 'Token has expired'
      end
    end

  end
end