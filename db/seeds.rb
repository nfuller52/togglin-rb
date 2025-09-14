# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

SEED_USER_PW = "Password1!"
SEED_USERS = ["test@example.com", "user@example.com", "admin@example.com"]

SEED_USERS.each do |email|
  User.find_or_create_by!(email: email) do |user|
    user.password = SEED_USER_PW
    user.password_confirmation = SEED_USER_PW
  end
end
