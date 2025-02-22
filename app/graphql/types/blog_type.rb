module Types
  class BlogType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :content, String, null: false
    field :created_at, String, null: false
    field :updated_at, String, null: false
    field :user, Types::UserType, null: false
  end
end