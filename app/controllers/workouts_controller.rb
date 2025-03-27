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

  def new_logged
    @workout = current_user.workouts.build(date: Date.current)
    render "new_logged"
  end

  def new_realtime
    @workout = current_user.workouts.build(date: Date.current)
    render "new_realtime"
  end

  def create_logged
    @workout = current_user.workouts.build(logged_workout_params)
    @workout.calculate_duration if @workout.start_time && @workout.end_time

    if @workout.save
      redirect_to edit_workout_path(@workout), notice: "Workout created. Add your exercises."
    else
      render :new_logged, status: :unprocessable_entity
    end
  end

  def create_realtime
    @workout = current_user.workouts.build(realtime_workout_params)
    @workout.start_time = Time.current
    @workout.date = Date.current

    if @workout.save
      redirect_to edit_workout_path(@workout), notice: "Workout started! Add your exercises."
    else
      render :new_realtime, status: :unprocessable_entity
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

    # Only allow a list of trusted parameters through.
    def workout_params
      params.require(:workout).permit(:name, :date, :start_time, :end_time, :notes)
    end

    def logged_workout_params
      params.require(:workout).permit(:name, :date, :start_time, :end_time, :notes)
    end

    def realtime_workout_params
      params.require(:workout).permit(:name, :notes)
    end
end
