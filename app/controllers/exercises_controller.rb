class ExercisesController < ApplicationController
  before_action :set_exercise, only: [ :show, :edit, :update ]

  def index
    if params[:search].present? && params[:search].strip.present?
      search_term = params[:search].strip
      @exercises = Exercise.where("name ILIKE ?", "%#{search_term}%").order(:name)
    else
      @exercises = Exercise.all.order(:name)
    end

    if params[:category].present?
      @exercises = @exercises.by_category(params[:category])
    end

    if params[:equipment_type].present?
      @exercises = @exercises.by_equipment(params[:equipment_type])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("exercise-select-list", partial: "routine_exercises/exercise_select_list", locals: { exercises: @exercises })
      end
    end
  end

  def show
    @exercise_logs = current_user.exercise_logs.where(exercise: @exercise)
                                 .includes(:workout, :sets)
                                 .order("workouts.date DESC")
  end

  def new
    @exercise = Exercise.new
  end

  def create
    @exercise = Exercise.new(exercise_params)

    if @exercise.save
      redirect_to exercises_path, notice: "Exercise was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @exercise.update(exercise_params)
      redirect_to exercises_path, notice: "Exercise was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_exercise
    @exercise = Exercise.find(params[:id])
  end

  def exercise_params
    params.require(:exercise).permit(:name, :category, :equipment_type, :description)
  end
end
