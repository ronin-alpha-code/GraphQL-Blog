module Mutations
  module Users
    class Login < BaseMutation
      # Define the required arguments for the mutation
      argument :email, String, required: true
      argument :password, String, required: true

      # Define the fields that will be returned by the mutation
      field :token, String, null: false
      field :user, Types::UserType, null: false
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
          success_message_response = JSON.parse({ message: 'Login successful' }.to_json)
          meta << success_message_response
          # Generate a JWT token with user_id and expiration time
          token = JWT.encode({ user_id: user.id, exp: 10.minutes }, 'secret', 'HS256')
          # Return the token, user, and meta information
          { token: token, user: user, meta: meta.as_json }
        else
          # If authentication fails, raise an error
          raise GraphQL::ExecutionError, 'Invalid email or password'
        end
      end
    end
  end
end