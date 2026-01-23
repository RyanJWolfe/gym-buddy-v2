class WorkoutsController < ApplicationController
  before_action :set_workout, only: [ :update ]
  before_action :set_workout_with_exercise_logs, only: [ :edit, :complete, :destroy ]

  # GET /workouts or /workouts.json
  def index
    @workouts = current_user.workouts.recent.includes(:exercise_logs)
  end

  # GET /workouts/1 or /workouts/1.json
  def show
    @workout = current_user.workouts.includes(exercise_logs: [ :exercise, :sets ]).find(params[:id])
    @exercise_logs = @workout.exercise_logs
  end

  # GET /workouts/new
  def new
    @routines = current_user.routines.includes([ :exercises ]).recent.published
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
      redirect_to edit_workout_path(@workout)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /workouts/1/edit
  def edit; end

  def complete
    @workout.duration_seconds = @workout.calculate_duration * 60 if @workout.start_time && @workout.end_time
  end

  # PATCH/PUT /workouts/1 or /workouts/1.json
  def update
    if @workout.update(workout_params)
      head :ok
    else
      @workout.exercise_logs.includes(:exercise, :sets)
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /workouts/1 or /workouts/1.json
  def destroy
    @workout.destroy # TODO bullet flagging n+1 query here

    respond_to do |format|
      format.html { redirect_to new_workout_path, notice: "Workout discarded." }
      format.turbo_stream
    end
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

  def set_workout_with_exercise_logs
    @workout = current_user.workouts.includes(exercise_logs: [ :exercise, :sets ]).find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def workout_params
    params.require(:workout).permit(
      :name,
      :date,
      :start_time,
      :end_time,
      :status,
      :routine_id,
      :autosave,
      exercise_logs_attributes: [
        :id, :exercise_id,
        :position, :notes, :equipment_brand, :_destroy,
        sets_attributes: [
          :id, :set_number, :reps, :weight, :rest_seconds, :_destroy
        ]
      ]
    )
  end
end
