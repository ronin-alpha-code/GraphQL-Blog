# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

USERS = [
  { email: 'john.doe@example.com', first_name: 'John', last_name: 'Doe', phone_number: '123-456-7890' },
  { email: 'jane.smith@example.com', first_name: 'Jane', last_name: 'Smith', phone_number: '234-567-8901' },
  { email: 'alice.jones@example.com', first_name: 'Alice', last_name: 'Jones', phone_number: '345-678-9012' },
  { email: 'bob.brown@example.com', first_name: 'Bob', last_name: 'Brown', phone_number: '456-789-0123' }
]

USERS.each do |data| 
  user = User.find_or_initialize_by(data)
  user.password = 'password'
  user.save!
end