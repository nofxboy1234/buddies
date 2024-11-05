# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
user1 = User.create!(name: 'user1')
user2 = User.create!(name: 'user2')
User.create!(name: 'user3')
User.create!(name: 'user4')

user1.friends << user2

author1 = Author.create!(name: 'author1')
author2 = Author.create!(name: 'author2')

author1.books.create(published_at: Time.now)
author1.books.create(published_at: Time.now)
author1.save!
