module Mutations
  module Users
    class UpdateUser < BaseMutation
      # Define the required arguments for the mutation
      include JwtAuthentication::ValidateJsonWebToken

      argument :token, String, required: true
      argument :first_name, String, required: false
      argument :last_name, String, required: false
      argument :phone_number, String, required: false

      field :user, Types::UserType, null: false
      field :response, String, null: true
      field :response_message, String, null: true

      def resolve(token:, first_name: nil, last_name: nil, phone_number: nil)
        # Validate the JWT token
        token = validate_json_web_token(token)
        # Find the user by the user_id in the JWT token
        user = User.find(token['id'])
        # Update the user attributes with the provided arguments
        if user.update!(
          first_name: first_name || user.first_name,
          last_name: last_name || user.last_name,
          phone_number: phone_number || user.phone_number
        )
        # Return the updated user
        { user: user, response: 'success', response_message: 'User updated successfully' }
        else
          # If user update fails, raise an error
          raise GraphQL::ExecutionError, user.errors.full_messages.join(', ')
        end
      end
    end
  end
end