class WorkoutsController < ApplicationController
  before_action :set_workout, only: [:show, :edit, :update, :destroy]

  # GET /workouts or /workouts.json
  def index
    @workouts = current_user.workouts.recent.includes(:exercise_logs)
  end

  # GET /workouts/1 or /workouts/1.json
  def show
    @exercise_logs = @workout.exercise_logs.includes(:exercise, :sets)
  end

  # GET /workouts/new
  def new
    @workout = current_user.workouts.build(date: Date.current)
  end

  # GET /workouts/1/edit
  def edit
  end

  # POST /workouts or /workouts.json
  def create
    @workout = current_user.workouts.build(workout_params)

    if @workout.save
      redirect_to @workout, notice: "Workout was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /workouts/1 or /workouts/1.json
  def update
    if @workout.update(workout_params)
      redirect_to @workout, notice: "Workout was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /workouts/1 or /workouts/1.json
  def destroy
    @workout.destroy
    redirect_to workouts_path, notice: "Workout was successfully deleted."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workout
      @workout = current_user.workouts.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def workout_params
      params.require(:workout).permit(:name, :date, :start_time, :end_time, :notes)
    end
end
