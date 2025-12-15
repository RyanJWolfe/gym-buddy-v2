# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# To load the exercises, run the following command:
#
#   RAILS_ENV=development bin/rails db:seed:exercises
#
# Demo seeds are now run explicitly via the rake task `db:seed:demo`.
# This file no longer auto-loads demo data so `bin/rails db:seed` is safe to run
# without creating demo workouts. To run demo seeds:
#
#   RAILS_ENV=development bin/rails db:seed:demo
#
puts "Seed completed successfully!"
