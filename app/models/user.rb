# Represents a user in the application.
# Inherits from ApplicationRecord which means it is an Active Record model backed by a database table.
# This class is used to interact with the users table in the database.
class User < ApplicationRecord
  has_secure_password

  # associations
  has_many :blogs, class_name: 'Blog', foreign_key: 'user_id', dependent: :destroy

  # Validates that the email is present and unique.
  validates :email, presence: true, uniqueness: true
  
  # Validates that the first name, last name and password is present.
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true, if: :new_record?
end
