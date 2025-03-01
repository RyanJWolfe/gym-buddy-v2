class ExportsController < ApplicationController
  def workouts
    @workouts = current_user.workouts.includes(exercise_logs: [:exercise, :sets])
    
    respond_to do |format|
      format.csv { send_data generate_workouts_csv, filename: "workouts-#{Date.today}.csv" }
      format.json { send_data JSON.pretty_generate(generate_workouts_json), filename: "workouts-#{Date.today}.json" }
    end
  end
  
  private
  
  def generate_workouts_csv
    require 'csv'
    
    CSV.generate(headers: true) do |csv|
      csv << ["Workout Name", "Date", "Exercise", "Set", "Weight (kg)", "Reps", "Volume (kg)", "Notes"]
      
      @workouts.each do |workout|
        workout.exercise_logs.each do |log|
          log.sets.each do |set|
            csv << [
              workout.name,
              workout.date,
              log.exercise.name,
              set.set_number,
              set.weight,
              set.reps,
              set.volume,
              set.notes
            ]
          end
        end
      end
    end
  end
  
  def generate_workouts_json
    @workouts.map do |workout|
      {
        id: workout.id,
        name: workout.name,
        date: workout.date,
        notes: workout.notes,
        exercises: workout.exercise_logs.map do |log|
          {
            id: log.id,
            exercise: {
              id: log.exercise.id,
              name: log.exercise.name,
              category: log.exercise.category,
              equipment_type: log.exercise.equipment_type
            },
            notes: log.notes,
            equipment_brand: log.equipment_brand,
            sets: log.sets.map do |set|
              {
                set_number: set.set_number,
                weight: set.weight,
                reps: set.reps,
                volume: set.volume,
                rest_seconds: set.rest_seconds,
                duration_seconds: set.duration_seconds,
                notes: set.notes
              }
            end
          }
        end
      }
    end
  end
end 