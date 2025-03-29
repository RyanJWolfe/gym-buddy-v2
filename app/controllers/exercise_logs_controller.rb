class ExerciseLogsController < ApplicationController
  before_action :set_workout
  before_action :set_exercise_log, only: [:edit, :update, :destroy]
  before_action :set_exercises, only: [:new, :edit]

  def new
    @exercise_log = @workout.exercise_logs.build

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def create
    @exercise_log = @workout.exercise_logs.build(exercise_log_params)

    if @exercise_log.save
      respond_to do |format|
        format.html { redirect_to edit_workout_path(@workout), notice: "Exercise added." }
        format.turbo_stream
      end
    else
      set_exercises
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @exercise_log.update(exercise_log_params)
      respond_to do |format|
        format.html { redirect_to edit_workout_path(@workout), notice: "Exercise added." }
        format.turbo_stream
      end
    else
      set_exercises
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @exercise_log.destroy
    redirect_to workout_path(@workout), notice: "Exercise was successfully removed."
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
