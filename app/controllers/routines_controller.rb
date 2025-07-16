class RoutinesController < ApplicationController
  before_action :set_routine, only: [:show, :edit, :update, :destroy, :start_workout]

  def index
    @routines = current_user.routines.includes(:exercises).order(updated_at: :desc)
  end

  def show
    @routine_exercises = @routine.routine_exercises.includes(:exercise)
  end

  def create
    @routine = current_user.routines.create!(
      name: "Untitled Routine",
      draft: true
    )

    if @routine.save
      redirect_to edit_routine_path(@routine), notice: "Routine was successfully created. Now add exercises."
    else
      redirect_back fallback_location: new_workout_path, alert: "Failed to create routine: #{@routine.errors.full_messages.join(', ')}"
    end
  end

  def edit
    @routine_exercises = @routine.routine_exercises.includes(:exercise)
  end

  def update
    if @routine.update(routine_params)
      respond_to do |format|
        format.html { redirect_to @routine, notice: "Routine was successfully updated." }
        format.json { render json: { status: "ok" }, status: :ok }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @routine.destroy
    redirect_to routines_path, notice: "Routine was successfully deleted."
  end

  # Start a new workout based on this routine
  def start_workout
    @workout = @routine.create_workout(current_user)

    if @workout
      redirect_to edit_workout_path(@workout), notice: "New workout started from routine!"
    else
      redirect_to @routine, alert: "Failed to create workout from routine."
    end
  end

  private

  def set_routine
    @routine = current_user.routines.find(params[:id])
  end

  def routine_params
    params.require(:routine).permit(:name, :description)
  end
end
