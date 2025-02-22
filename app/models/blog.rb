class Blog < ApplicationRecord
  # Represents a blog in the application.
  # Inherits from ApplicationRecord which means it is an Active Record model backed by a database table.

  # associations
  belongs_to :user

  # validations
  validates :title, :content, presence: true
end