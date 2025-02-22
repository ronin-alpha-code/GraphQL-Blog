module Mutations
  module Users
    class DestroyUser < BaseMutation

      argument :token, String, required: true

      field :user, Types::UserType, null: true
      field :errors, [String], null: true
      field :response, String, null: true
      field :response_message, String, null: true

      def resolve(token:)
        token = validate_json_web_token(token)
        user = User.find_by_id(token['id'])

        raise GraphQL::ExecutionError, "User not found" if user.nil?
        if user.destroy
          { response: "success", response_message: "User deleted successfully" }
        else
          raise GraphQL::ExecutionError, user.errors.full_messages.join(", ")
        end
      end
    end
  end
end