class RoutinesController < ApplicationController
  before_action :set_routine, only: [ :show, :update, :destroy, :start_workout ]
  before_action :hide_footer, only: [ :new, :edit ]

  def index
    @routines = current_user.routines.includes(:exercises).order(updated_at: :desc)
  end

  def show
    @routine_exercises = @routine.routine_exercises.includes(:exercise)
  end

  def share_text
    @routine = current_user.routines.find(params[:id])

    cache_key = "routine:#{@routine.id}:share_text:#{@routine.updated_at.to_i}"

    @share_text = Rails.cache.fetch(cache_key) do
      @routine.share_text
    end
  end

  def new
    @routine = current_user.routines.new
    @routine_exercises = []
  end

  def create
    @routine = current_user.routines.new(routine_params)
    @routine.draft = false # Routine is not a draft, since user is intentionally saving

    if @routine.save
      # TODO: maybe anchor to newly created routine?
      redirect_to new_workout_path, notice: "#{@routine.name} routine was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @routine = current_user.routines.includes(routine_exercises: [ :exercise, :routine_sets ]).find(params[:id])
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
    routine_name = @routine.name
    @routine.destroy # TODO: move to background job if performance becomes an issue

    respond_to do |format|
      format.html { redirect_to new_workout_path, notice: "#{routine_name} was successfully deleted." }
      format.turbo_stream { render turbo_stream: [
        turbo_stream.remove(@routine),
        turbo_stream.update("general-routines-count", "General Routines (#{current_user.routines.count})")
      ] }
    end
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
    params.require(:routine).permit(
      :name, :description,
      routine_exercises_attributes: [
        :id, :exercise_id, :position, :rest_seconds, :notes, :equipment_brand, :_destroy,
        routine_sets_attributes: [
          :id, :set_number, :reps, :weight, :rest_seconds, :_destroy
        ]
      ]
    )
  end
end
