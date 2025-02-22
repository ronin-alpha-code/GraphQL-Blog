module Mutations
  module Blogs

    # DestroyBlog is a mutation that allows a user to delete a blog post.
    # 
    # Arguments:
    # - token: A JSON Web Token (JWT) that is used to authenticate the user.
    # - id: The ID of the blog post to be deleted.
    #
    # Fields:
    # - response: A string indicating the status of the mutation ('success' if the blog was deleted successfully).
    # - response_message: A string containing a message about the result of the mutation.
    #
    # resolve(token:, id:) method:
    # - Validates the provided JWT token.
    # - Finds the user associated with the token.
    # - Raises an error if the user is not found.
    # - Finds the blog post associated with the user and the provided blog ID.
    # - Raises an error if the blog post is not found.
    # - Attempts to delete the blog post.
    # - Returns a success response if the blog post is deleted successfully.
    # - Raises an error if the blog post cannot be deleted, including any error messages.
    class DestroyBlog < BaseMutation
      argument :token, String, required: true
      argument :id, ID, required: true

      field :response, String, null: true
      field :response_message, String, null: true

      def resolve(token:, id:)
        token = validate_json_web_token(token)
        user = User.find_by_id(token['id'])

        raise GraphQL::ExecutionError, 'User not found' if user.nil?
        blog = user.blogs.find_by_id(id)

        raise GraphQL::ExecutionError, 'Blog not found' if blog.nil?
        if blog.destroy
          { response: 'success', response_message: 'Blog deleted successfully' }
        else
          raise GraphQL::ExecutionError, blog.errors.full_messages.join(', ')
        end
      end
    end
  end
end