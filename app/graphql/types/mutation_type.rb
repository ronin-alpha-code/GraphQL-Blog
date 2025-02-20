module Types
  # The MutationType class defines the root-level mutations for the GraphQL API.
  # It inherits from Types::BaseObject and includes fields for various mutations.
  #
  # Fields:
  # - test_field: An example field added by the generator that returns a "Hello World" string.
  # - login: A mutation for user login, defined in Mutations::Users::Login.
  # - create_user: A mutation for creating a new user, defined in Mutations::Users::CreateUser.
  class MutationType < Types::BaseObject
    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World"
    end

    field :login, mutation: Mutations::Users::Login
    field :create_user, mutation: Mutations::Users::CreateUser
  end
end
