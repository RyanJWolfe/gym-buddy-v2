class ExerciseLogsController < ApplicationController
  before_action :set_workout
  before_action :set_exercise_log, only: [ :update, :destroy ]
  def create
    next_position = @workout.exercise_logs.size + 1
    if params[:exercise_ids].present?
      @exercise_logs = ExerciseLog.from_exercise_ids(@workout, params[:exercise_ids])
      ExerciseLog.transaction do
        @exercise_logs.each do |exercise_log|
          exercise_log.position = next_position
          exercise_log.save!
          next_position += 1
        end
      end
      respond_to do |format|
        format.html { redirect_to edit_workout_path(@workout), notice: "Exercises added." }
        format.turbo_stream
      end
      return
    end

    @exercise_log = @workout.exercise_logs.build(exercise_log_params)
    @exercise_log.position = next_position

    if @exercise_log.save
      respond_to do |format|
        format.html { redirect_to edit_workout_path(@workout), notice: "Exercise added." }
        format.turbo_stream
      end
    else
      render head: :unprocessable_entity
    end
  end

  def update
    if @exercise_log.update(exercise_log_params)
      respond_to do |format|
        format.html { redirect_to edit_workout_path(@workout), notice: "Exercise added." }
        format.turbo_stream
      end
    else
      render head: :unprocessable_entity
    end
  end

  def destroy
    @exercise_log.destroy
    @workout.reindex_exercise_logs!

    respond_to do |format|
      format.html { redirect_to workout_path(@workout), notice: "Exercise was successfully removed." }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@exercise_log) }
    end
  end

  private

  def set_workout
    @workout = current_user.workouts.find(params[:workout_id])
  end

  def set_exercise_log
    @exercise_log = @workout.exercise_logs.find(params[:id])
  end

  def set_exercises
    @exercises = Exercise.all.alphabetical
  end

  def exercise_log_params
    params.require(:exercise_log).permit(:exercise_id, :notes, :equipment_brand)
  end

end
