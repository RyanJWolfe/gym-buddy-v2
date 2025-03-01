class ExerciseLogsController < ApplicationController
  before_action :set_workout
  before_action :set_exercise_log, only: [:show, :edit, :update, :destroy]
  
  def new
    @exercise_log = @workout.exercise_logs.build
    @exercises = Exercise.all.order(:name)
  end
  
  def create
    @exercise_log = @workout.exercise_logs.build(exercise_log_params)
    
    if @exercise_log.save
      redirect_to workout_path(@workout), notice: 'Exercise was successfully added.'
    else
      @exercises = Exercise.all.order(:name)
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    @exercises = Exercise.all.order(:name)
  end
  
  def update
    if @exercise_log.update(exercise_log_params)
      redirect_to workout_path(@workout), notice: 'Exercise was successfully updated.'
    else
      @exercises = Exercise.all.order(:name)
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @exercise_log.destroy
    redirect_to workout_path(@workout), notice: 'Exercise was successfully removed.'
  end
  
  private
  
  def set_workout
    @workout = current_user.workouts.find(params[:workout_id])
  end
  
  def set_exercise_log
    @exercise_log = @workout.exercise_logs.find(params[:id])
  end
  
  def exercise_log_params
    params.require(:exercise_log).permit(:exercise_id, :notes, :equipment_brand)
  end
end 