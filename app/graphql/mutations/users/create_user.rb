module Mutations
  module Users
    class CreateUser < BaseMutation
      # Define the required arguments for the mutation
      argument :email, String, required: true
      argument :first_name, String, required: true
      argument :last_name, String, required: true
      argument :phone_number, String, required: false
      argument :password, String, required: true

      field :user, Types::UserType, null: false
      field :token, String, null: false
      field :meta, [String], null: true

      def resolve(email:, first_name:, last_name:, phone_number:, password:)
        meta = []
        # Find the user by email
        user = User.find_by(email: email)
        # If user is found, raise an error
        raise GraphQL::ExecutionError, 'User already exists' if user

        # Create a new user with the provided arguments
        user = User.new(email: email, first_name: first_name, last_name: last_name, phone_number: phone_number)
        user.password = password
        if user.save!
          success_message_response = JSON.parse({ message: 'User created successfully' }.to_json)
          meta << success_message_response
          # Generate a JWT token with user_id and expiration time
          token = token = JwtAuthentication::AuthenticateJwtToken.encode(user.id)
          # Return the user and token information
            { user: user, token: token, meta: meta.as_json }
          else
          raise GraphQL::ExecutionError, user.errors.full_messages.join(', ')
        end
      end
    end
  end
end