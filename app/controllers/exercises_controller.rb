class ExercisesController < ApplicationController
  before_action :load_user
  before_action :set_exercise, only: %i[ show edit update destroy ]

  # GET /exercises or /exercises.json
  def index
    @exercises = @exercises.order(created_at: :asc)
  end

  # GET /exercises/1 or /exercises/1.json
  def show
  end

  # GET /exercises/new
  def new
    @exercise = @exercises.build
  end

  # GET /exercises/1/edit
  def edit
  end

  # POST /exercises or /exercises.json
  def create
    @exercise = @exercises.build(exercise_params)

    respond_to do |format|
      if @exercise.save
        redirect_path = @user ? user_exercises_path(@user) : root_path
        format.html { redirect_to redirect_path, notice: "Exercise was successfully created." }
        format.json { render :show, status: :created, location: @exercise }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exercises/1 or /exercises/1.json
  def update
    respond_to do |format|
      if @exercise.update(exercise_params)
        redirect_path = @user ? user_exercises_path(@user) : root_path
        format.html { redirect_to redirect_path, notice: "Exercise was successfully updated." }
        format.json { render :show, status: :ok, location: @exercise }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exercises/1 or /exercises/1.json
  def destroy
    @exercise.destroy
    redirect_path = @user ? user_exercises_path(@user) : root_path

    respond_to do |format|
      format.html { redirect_to redirect_path, notice: "Exercise was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exercise
      @exercise = @user ? @exercises.find_by_id(params[:id]) : Exercise.find(params[:id])
    end

    def load_user
      # todo validate user id against workout id (i.e. if user has access to workout)
      @user = User.find(params[:user_id]) if params[:user_id]
      @exercises = @user ? @user.exercises : Exercise.all
    end

    # Only allow a list of trusted parameters through.
    def exercise_params
      params.require(:exercise).permit(:name, :workout_id, :user_id)
    end
end
