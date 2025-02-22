module Mutations
  module Users
    class Login < BaseMutation
      # Define the required arguments for the mutation
      argument :email, String, required: true
      argument :password, String, required: true

      # Define the fields that will be returned by the mutation
      field :token, String, null: false
      field :user, Types::UserType, null: false
      field :response, String, null: true
      field :response_message, String, null: true
      field :meta, [String], null: true

      # The resolve method is where the mutation logic is implemented
      def resolve(email:, password:)
        # Find the user by email
        user = User.find_by(email: email)
        # If user is not found, raise an error
        raise GraphQL::ExecutionError, 'User not found' unless user
        meta = []
        
        # Authenticate the user with the provided password
        if user&.authenticate(password)
          # If authentication is successful, add a success message to meta
          success_message_response = [{ message: 'Login successful' }]
          response = 'success'
          response_message = 'Login successful'
          meta += success_message_response
          # Generate a JWT token with user_id and expiration time
          token = JwtAuthentication::AuthenticateJwtToken.encode(user.id)
          # Return the token, user, and meta information
          { token: token, user: user, meta: meta, response: response, response_message: response_message }
        else
          # If authentication fails, raise an error
          raise GraphQL::ExecutionError, 'Invalid email or password'
        end
      end
    end
  end
end