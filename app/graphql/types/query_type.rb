module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField
    include JwtAuthentication::ValidateJsonWebToken

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # fetch a user by token
    field :user, Types::UserType, null: false do
      argument :token, String, required: true
    end

    def user(token:)
      token = validate_json_web_token(token)
      User.find(token['id'])
    end

    ## fetch blogs by token
    # @param token [String] The JWT token for authentication
    # @return [Array<Types::BlogType>] List of blogs associated with the user
    field :blogs, [Types::BlogType], null: false do
      argument :token, String, required: true
      argument :id, ID, required: false
    end

    ## fetch a specific blog by token and id
    # @param token [String] The JWT token for authentication
    # @param id [ID] The ID of the blog to fetch
    # @return [Types::BlogType] The blog associated with the given ID
    field :blog, Types::BlogType, null: false do
      argument :token, String, required: true
      argument :id, ID, required: true
    end

    def blogs(token:)
      token = validate_json_web_token(token)
      Blog.where(user_id: token['id'])
    end

    def blog(token:, id:)
      token = validate_json_web_token(token)
      user = User.find_by_id(token['id'])
      raise GraphQL::ExecutionError, 'User not found' if user.nil?
      raise GraphQL::ExecutionError, "Blog not found" unless user.blogs.find_by_id(id)
    end

    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end
  end
end
