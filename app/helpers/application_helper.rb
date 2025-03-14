module ApplicationHelper
  include Pagy::Frontend
  
  def page_title(title = nil)
    if title.present?
      "#{title} - GymTracker"
    else
      "GymTracker"
    end
  end
  
  def active_link_class(path)
    if current_page?(path)
      "bg-indigo-800 text-white"
    else
      "text-indigo-100 hover:bg-indigo-800 hover:text-white"
    end
  end
  
  def format_weight(weight)
    return 0 if weight.nil?
    weight.round(1)
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

  def format_time(time)
    return nil if time.nil?
    time.strftime("%l:%M %p").strip
  end
end
