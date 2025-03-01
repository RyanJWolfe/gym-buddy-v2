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
end
