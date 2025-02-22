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

    ## Mutations for users
    field :login, mutation: Mutations::Users::Login
    field :create_user, mutation: Mutations::Users::CreateUser
    field :update_user, mutation: Mutations::Users::UpdateUser
    field :destroy_user, mutation: Mutations::Users::DestroyUser

    ## Mutations for blogs
    field :create_blog, mutation: Mutations::Blogs::CreateBlog
    field :update_blog, mutation: Mutations::Blogs::UpdateBlog
    field :destroy_blog, mutation: Mutations::Blogs::DestroyBlog
  end
end
