module Mutations
  module Blogs

    # UpdateBlog is a mutation that allows a user to update an existing blog post.
    #
    # Arguments:
    # - token: A valid JSON Web Token (JWT) for authenticating the user (String, required).
    # - id: The ID of the blog post to be updated (ID, required).
    # - title: The new title for the blog post (String, optional).
    # - content: The new content for the blog post (String, optional).
    #
    # Fields:
    # - blog: The updated blog post (Types::BlogType, non-nullable).
    # - response: A status message indicating the result of the mutation (String, nullable).
    # - response_message: A detailed message about the result of the mutation (String, nullable).
    # - user: The user who owns the blog post (Types::UserType, non-nullable).
    #
    # Raises:
    # - GraphQL::ExecutionError: If the user is not found, the blog post is not found, or the update fails.
    #
    # Example usage:
    # mutation {
    #   updateBlog(token: "valid_token", id: "blog_id", title: "New Title", content: "New Content") {
    #     blog {
    #       id
    #       title
    #       content
    #     }
    #     response
    #     response_message
    #     user {
    #       id
    #       name
    #     }
    #   }
    # }
    class UpdateBlog < BaseMutation
      argument :token, String, required: true
      argument :id, ID, required: true
      argument :title, String, required: false
      argument :content, String, required: false

      field :blog, Types::BlogType, null: false
      field :response, String, null: true
      field :response_message, String, null: true
      field :user, Types::UserType, null: false

      def resolve(token:, id:, title: nil, content: nil)
        token = validate_json_web_token(token)
        user = User.find_by_id(token['id'])

        raise GraphQL::ExecutionError, 'User not found' if user.nil?
        blog = user.blogs.find_by_id(id)

        raise GraphQL::ExecutionError, 'Blog not found' if blog.nil?
        if blog.update(
          title: title || blog.title,
          content: content || blog.content
        )
          { blog: blog, response: 'success', response_message: 'Blog updated successfully', user: user }
        else
          raise GraphQL::ExecutionError, blog.errors.full_messages.join(', ')
        end
      end
    end
  end
end