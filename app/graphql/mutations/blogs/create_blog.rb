module Mutations
  module Blogs

    # CreateBlog mutation class handles the creation of a new blog post.
    # 
    # Arguments:
    # - token: A JSON Web Token (JWT) string that is required for authentication.
    # - title: The title of the blog post.
    # - content: The content of the blog post.
    #
    # Fields:
    # - blog: The newly created blog post of type BlogType.
    # - response: A string indicating the status of the mutation ('success' or 'failure').
    # - response_message: A string containing a message about the result of the mutation.
    # - user: The user who created the blog post of type UserType.
    #
    # Methods:
    # - resolve(token:, title:, content:): This method validates the token, finds the user, 
    #   creates a new blog post, and returns the appropriate response.
    #   Raises GraphQL::ExecutionError if the user is not found or if the blog post fails to save.
    class CreateBlog < BaseMutation
      argument :token, String, required: true
      argument :title, String, required: true
      argument :content, String, required: true

      field :blog, Types::BlogType, null: false
      field :response, String, null: true
      field :response_message, String, null: true
      field :user, Types::UserType, null: false

      def resolve(token:, title:, content:)
        token = validate_json_web_token(token)
        user = User.find_by_id(token['id'])

        raise GraphQL::ExecutionError, 'User not found' if user.nil?
        blog = user.blogs.new(title: title, content: content)
        if blog.save
          { blog: blog, response: 'success', response_message: "Blog created successfully.", user: user }
        else
          raise GraphQL::ExecutionError, blog.errors.full_messages.join(', ')
        end
      end
    end
  end
end