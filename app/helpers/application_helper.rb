module ApplicationHelper
  include Pagy::Frontend
  
  def page_title(title = nil)
    if title.present?
      "#{title} | GymTracker"
    else
      "GymTracker"
    end
  end
  
  def active_link_class(path)
    current_page?(path) ? "bg-indigo-700 text-white" : "text-white hover:bg-indigo-700"
  end
  
  def format_weight(weight)
    return "-" if weight.nil?
    
    formatted = weight.to_f
    formatted % 1 == 0 ? formatted.to_i : formatted
  end

  def format_duration(minutes)
    return "N/A" if minutes.nil?
    
    formatted = minutes.to_f
    "#{formatted % 1 == 0 ? formatted.to_i : formatted} min"
  end
end
