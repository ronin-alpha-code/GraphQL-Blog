module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField
    include JwtAuthentication::ValidateJsonWebToken

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :user, Types::UserType, null: false do
      argument :token, String, required: true
    end

    def user(token:)
      token = validate_json_web_token(token)
      User.find(token['id'])
    end
    
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end
  end
end
