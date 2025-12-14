# lib/tasks/seed_demo.rake
# Rake task to run demo seeds separately from the main seeds file.
# Usage:
#   RAILS_ENV=development bin/rails db:seed:demo
# or (when in development already):
#   bin/rails db:seed:demo

namespace :db do
  namespace :seed do
    desc "Run demo seeds (development only). Loads db/seeds/demo.rb"
    task demo: :environment do
      if Rails.env.development?
        demo_seed = Rails.root.join("db", "seeds", "demo.rb")
        if File.exist?(demo_seed)
          puts "Running demo seed: #{demo_seed}"
          # Use load so the file is executed fresh each time
          load demo_seed.to_s
          puts "Demo seed completed."
        else
          puts "Demo seed file not found: #{demo_seed}"
          exit 1
        end
      else
        puts "Skipping demo seed: only intended to run in development (Rails.env=#{Rails.env})."
        puts "To run, execute: RAILS_ENV=development bin/rails db:seed:demo"
      end
    end
  end
end
