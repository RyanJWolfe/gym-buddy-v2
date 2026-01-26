module ApplicationHelper
  def app_name
    "Iron Logs"
  end
  def page_title(title = nil)
    if title.present?
      "#{title} - #{app_name}"
    else
      app_name
    end
  end

  def active_link_class(path)
    if current_page?(path)
      "text-indigo-600 bg-indigo-50"
    else
      "text-gray-500 hover:text-indigo-600"
    end
  end

  def format_weight(weight)
    return "-" if weight.nil?

    formatted = weight.to_f
    formatted % 1 == 0 ? formatted.to_i : formatted
  end

  def abbreviate_weight(weight)
    return "-" if weight.nil?

    weight = weight.to_f
    if weight >= 1000
      "#{(weight / 1000).round(1)}k"
    else
      weight.to_i
    end
  end

  def current_user_active_workout
    @active_workout
  end

  def on_active_workout_edit_page?
    return false unless current_user_active_workout

    controller_name == 'workouts' && action_name == 'edit' && params[:id].to_s == current_user_active_workout.id.to_s
  end

  def show_active_workout_indicator?
    current_user_active_workout.present? && !on_active_workout_edit_page?
  end

  def format_duration(minutes)
    return "0 min" if minutes.nil? || minutes.zero?

    if minutes < 60
      "#{minutes} min"
    else
      hours = (minutes / 60).to_i
      remaining_minutes = (minutes % 60).to_i

      if remaining_minutes.zero?
        "#{hours} hr"
      else
        "#{hours} hr #{remaining_minutes} min"
      end
    end
  end

  # Format time to display in 12-hour format with AM/PM
  def format_time(time)
    return nil if time.nil?

    time.strftime("%l:%M %p").strip
  end
end
