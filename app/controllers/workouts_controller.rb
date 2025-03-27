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
    @workout.logged_workout = (params[:type] == "logged")

    if params[:type].present?
      render workout_type == "logged" ? "new_logged" : "new_realtime"
    end
  end

  # POST /workouts
  def create
    @workout = current_user.workouts.build(workout_params)
    @workout.logged_workout = (params[:type] == "logged")

    if workout_type == "logged"
      @workout.calculate_duration if @workout.start_time && @workout.end_time
    else
      @workout.start_time = Time.current
      @workout.date = Date.current
    end

    if @workout.save
      redirect_to edit_workout_path(@workout),
        notice: workout_type == "logged" ? "Workout created. Add your exercises." : "Workout started! Add your exercises."
    else
      render workout_type == "logged" ? "new_logged" : "new_realtime",
        status: :unprocessable_entity
    end
  end

  # GET /workouts/1/edit
  def edit
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

    def workout_type
      params[:type]&.to_s == "logged" ? "logged" : "realtime"
    end
    helper_method :workout_type

    # Only allow a list of trusted parameters through.
    def workout_params
      if workout_type == "logged"
        params.require(:workout).permit(:name, :date, :start_time, :end_time, :notes)
      else
        params.require(:workout).permit(:name, :notes)
      end
    end
end
