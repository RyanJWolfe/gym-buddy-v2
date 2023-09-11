class WorkoutsController < ApplicationController
  before_action :load_user
  before_action :set_workout, only: %i[ show edit update destroy ]

  # GET /workouts or /workouts.json
  def index
    @workouts = @workouts.order(date: :desc)
  end

  # GET /workouts/1 or /workouts/1.json
  def show
    @exercises = @workout.exercises
  end

  # GET /workouts/new
  def new
    @workout = @workouts.build
  end

  # GET /workouts/1/edit
  def edit
  end

  # POST /workouts or /workouts.json
  def create
    @workout = @workouts.build(workout_params)

    respond_to do |format|
      if @workout.save
        redirect_path = @user ? user_workout_path(@user, @workout) : root_path
        format.html { redirect_to redirect_path, notice: "Workout was successfully created." }
        format.json { render :show, status: :created, location: @workout }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @workout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workouts/1 or /workouts/1.json
  def update
    respond_to do |format|
      if @workout.update(workout_params)
        redirect_path = @user ? user_workout_url(@user, @workout) : root_path

        format.html { redirect_to redirect_path, notice: "Workout was successfully updated." }
        format.json { render :show, status: :ok, location: @workout }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @workout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workouts/1 or /workouts/1.json
  def destroy
    @workout.destroy

    redirect_path = @user ? user_workouts_url(@user) : root_path

    respond_to do |format|
      format.html { redirect_to redirect_path, notice: "Workout was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def add_exercise
    workout = @workouts.find(params[:workout_id])
    # routine.routine_exercises.build
    helpers.fields model: workout do |f|
      we = WorkoutExercise.new
      we.exercise_sets.build
      f.fields_for :workout_exercises, we, child_index: Time.now.to_f do |ff|
        render turbo_stream: turbo_stream.append(
          'workout_exercises',
          partial: 'workouts/workout_exercise_fields',
          locals: { f: ff, workout: }
        )
      end
    end
  end

  def remove_exercise
    # TODO: This was generated and is untested
    workout = @workouts.find(params[:workout_id])
    workout.workout_exercises.find(params[:id]).destroy
    redirect_to edit_user_workout_path(current_user, workout)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workout
      @workout = @workouts.find(params[:id])
    end

    def load_user
      @user = User.find(params[:user_id]) if params[:user_id]
      @workouts = @user ? @user.workouts : Workout.all
    end

    # Only allow a list of trusted parameters through.
    def workout_params
      params.require(:workout).permit(:user_id, :workout_type_id, :date, :duration, workout_exercises_attributes: {})
    end
end
