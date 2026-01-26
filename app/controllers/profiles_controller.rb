class ProfilesController < ApplicationController
  before_action :set_user

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to profile_path, notice: "Profile was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

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
