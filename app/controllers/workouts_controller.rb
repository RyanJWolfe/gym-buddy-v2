class WorkoutsController < ApplicationController
  before_action :set_workout, only: [:update, :destroy]

  # GET /workouts or /workouts.json
  def index
    @workouts = current_user.workouts.recent.includes(:exercise_logs)
  end

  # GET /workouts/1 or /workouts/1.json
  def show
    @workout = current_user.workouts.includes(exercise_logs: [:exercise, :sets]).find(params[:id])
    @exercise_logs = @workout.exercise_logs
  end

  # GET /workouts/new
  def new
    @routines = current_user.routines.includes([:exercises]).recent.published
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
    @workout = current_user.workouts.includes(exercise_logs: [:exercise, :sets]).find(params[:id])
  end

  # PATCH/PUT /workouts/1 or /workouts/1.json
  def update
    if @workout.update(workout_params)
      redirect_to @workout, notice: "Workout was successfully updated."
    else
      @exercise_logs = @workout.exercise_logs.includes(:exercise, :sets)
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /workouts/1 or /workouts/1.json
  def destroy
    @workout.destroy
    redirect_to workouts_path, notice: "Workout was successfully deleted."
  end

  def create_duplicate
    @source_workout = current_user.workouts.find(params[:id])

    # Find the last workout in the template family
    max_sequence = @source_workout.template_family.maximum(:sequence_number) || 0

    # clone the workout
    @workout = @source_workout.amoeba_dup # TODO: potential n+1 query here
    @workout.date = Date.current
    @workout.start_time = Time.current
    @workout.end_time = nil
    @workout.sequence_number = max_sequence + 1

    @workout.template = @source_workout
    @workout.template_name = @source_workout.template_name || @source_workout.name

    if @workout.save
      redirect_to edit_workout_path(@workout), notice: "Workout duplicated successfully!"
    else
      render :new_duplicate, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_workout
    @workout = current_user.workouts.find(params[:id])
  end

  def workout_type
    params[:type]&.to_s || "logged"
  end

  helper_method :workout_type

  # Only allow a list of trusted parameters through.
  def workout_params
    if workout_type == "logged"
      params.require(:workout).permit(:name, :date, :start_time, :end_time, :notes)
    else
      params.require(:workout).permit(:name, :notes, :status)
    end
  end
end
