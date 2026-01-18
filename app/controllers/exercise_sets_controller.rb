class ExerciseSetsController < ApplicationController
  before_action :set_workout
  before_action :set_exercise_log
  before_action :set_exercise_set, only: [ :edit, :update, :destroy ]

  def new
    @set = @exercise_log.sets.build(set_number: next_set_number)
  end

  def create
    if params[:exercise_set]
      @set = @exercise_log.sets.build(exercise_set_params)
    else
      @set = @exercise_log.sets.build(set_number: next_set_number)
    end

    if @set.save
      respond_to do |format|
        format.html { redirect_to workout_path(@workout), notice: "Set was successfully added." }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @set.update(exercise_set_params)
      respond_to do |format|
        format.html { redirect_to workout_path(@workout), notice: "Set was successfully updated." }
        format.json { head :no_content }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @set.destroy
    @exercise_log.reindex_sets!

    respond_to do |format|
      format.html { redirect_to workout_path(@workout), notice: "Set was successfully deleted." }
      format.turbo_stream
    end
  end

  private

  def set_workout
    @workout = current_user.workouts.find(params[:workout_id])
  end

  def set_exercise_log
    @exercise_log = @workout.exercise_logs.find(params[:exercise_log_id])
  end

  def set_exercise_set
    @set = @exercise_log.sets.find(params[:id])
  end

  def exercise_set_params
    params.require(:exercise_set).permit(:set_number, :reps, :weight, :rest_seconds, :duration_seconds, :notes)
  end

  def next_set_number
    (@exercise_log.sets.maximum(:set_number) || 0) + 1
  end
end
