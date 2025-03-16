class ProfilesController < ApplicationController
  def show
    @user = current_user
    @total_workouts = @user.workouts.count
    @total_volume = calculate_total_volume
    @workout_streak = calculate_workout_streak
    @favorite_exercise = @user.favorite_exercises(1).first
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      redirect_to profile_path, notice: "Profile was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def calculate_total_volume
    current_user.workouts.joins(exercise_logs: :sets)
                .sum("exercise_sets.reps * exercise_sets.weight")
  end

  def calculate_workout_streak
    workouts = current_user.workouts.order(date: :desc).pluck(:date)
    return 0 if workouts.empty?

    streak = 1
    last_date = workouts.first

    workouts[1..-1].each do |date|
      if last_date - date == 1
        streak += 1
        last_date = date
      else
        break
      end
    end

    streak
  end
end
