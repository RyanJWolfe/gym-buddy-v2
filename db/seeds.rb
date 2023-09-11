# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create workout types
workout_types = WorkoutType.create([
  { name: "Run" },
  { name: "Bike" },
  { name: "Swim" },
  { name: "Strength" },
  { name: "Yoga" },
  { name: "Pilates" },
  { name: "Stretch" },
  { name: "Walk" },
  { name: "Hike" },
  { name: "Climb" },
  { name: "Other" }
])

# create test user
user = User.find_by(email: 'xryanwolfe@gmail.com')
user ||= User.create!(email: 'xryanwolfe@gmail.com', password: 'password', password_confirmation: 'password')