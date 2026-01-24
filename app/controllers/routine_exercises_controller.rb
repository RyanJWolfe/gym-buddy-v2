class RoutineExercisesController < ApplicationController
  def exercise_select_modal # TODO: find a better place for this action
    @exercises = Rails.cache.fetch("exercises_with_categories", expires_in: 12.hours) do
      Exercise.all.includes(:categories).order(:name).to_a
    end

    @mode = params[:mode] || "add" # "add" or "replace"
    if @mode == "replace"
      @target_dom_id = params[:target_dom_id]
      @target_id = params[:target_id]
    end
  end
end
