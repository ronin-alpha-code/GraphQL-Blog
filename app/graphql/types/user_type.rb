module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :first_name, String, null: false
    field :last_name, String, null: false
    field :phone_number, String, null: true
    field :full_name, String, null: false
    field :blogs, [Types::BlogType], null: true

    def full_name
      [object.first_name, object.last_name].join(' ')
    end
  end
end