class RoutineExercisesController < ApplicationController
  before_action :set_routine
  before_action :set_routine_exercise, only: [:update, :destroy]

  def new
    @routine_exercise = @routine.routine_exercises.build
    @routine_exercise.suggested_sets = 3
    @routine_exercise.suggested_reps = 10

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
  def create
    @routine_exercise = @routine.routine_exercises.build(routine_exercise_params)

    if @routine_exercise.save
      redirect_to edit_routine_path(@routine), notice: "Exercise added to routine."
    else
      redirect_to edit_routine_path(@routine), alert: "Could not add exercise: #{@routine_exercise.errors.full_messages.join(', ')}"
    end
  end

  def update
    if @routine_exercise.update(routine_exercise_params)
      redirect_to edit_routine_path(@routine), notice: "Exercise updated."
    else
      redirect_to edit_routine_path(@routine), alert: "Could not update exercise: #{@routine_exercise.errors.full_messages.join(', ')}"
    end
  end

  def destroy
    @routine_exercise.destroy
    redirect_to edit_routine_path(@routine), notice: "Exercise removed from routine."
  end

  def sort
    params[:order].each_with_index do |id, index|
      @routine.routine_exercises.find(id).update(position: index + 1)
    end
    head :no_content
  end

  private

  def set_routine
    @routine = current_user.routines.find(params[:routine_id])
  end

  def set_routine_exercise
    @routine_exercise = @routine.routine_exercises.find(params[:id])
  end

  def routine_exercise_params
    params.require(:routine_exercise).permit(
      :exercise_id,
      :position,
      :suggested_sets,
      :suggested_reps,
      :rest_seconds,
      :notes,
      :equipment_brand
    )
  end
end
