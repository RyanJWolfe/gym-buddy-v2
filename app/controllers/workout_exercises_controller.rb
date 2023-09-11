class WorkoutExercisesController < ApplicationController
  def add_set
    workout = @workouts.find(params[:workout_id])
    workout_exercise = workout.workout_exercises.find(params[:workout_exercise_id])
    helpers.fields model: workout_exercise do |f|
      f.fields_for :exercise_sets, ExerciseSet.new, child_index: Time.now.to_f do |ff|
        render turbo_stream: turbo_stream.append(
          'exercise_sets',
          partial: 'workouts/exercise_set_fields',
          locals: { f: ff }
        )
      end
    end
  end
end
