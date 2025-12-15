# lib/tasks/seed_exercises.rake
namespace :db do
  namespace :seed do
    desc "Seed exercises from db/seeds/exercises.rb"
    task exercises: :environment do
      # Load the exercises data
      load Rails.root.join("db/seeds/exercises.rb")

      puts "Creating exercises and categories..."
      EXERCISES.each do |exercise_data|
        # Use a unique list of exercises based on name to avoid duplicates
        exercise = Exercise.find_or_initialize_by(name: exercise_data[:name])

        exercise.assign_attributes(
          equipment_type: exercise_data[:equipment_type],
          description: exercise_data[:description]
        )

        categories = exercise_data[:categories].map do |category_name|
          Category.find_or_create_by!(name: category_name)
        end

        exercise.categories = categories
        exercise.save!
      end

      puts "Created #{Exercise.count} exercises"
      puts "Created #{Category.count} categories"
      puts "Exercises seed completed successfully!"
    end
  end
end
