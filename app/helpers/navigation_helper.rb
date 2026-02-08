module NavigationHelper
  TAB_MAPPING = {
    "home#index" => :home,
    "workouts#index" => :home,
    "workouts#show" => :home,
    "workouts#new" => :workout,
    "workouts#edit" => :workout,
    "routines#index" => :workout,
    "routines#show" => :workout,
    "routines#new" => :workout,
    "routines#edit" => :workout,
    "exercises#index" => :workout,
    "exercises#show" => :workout,
    "exercises#new" => :workout,
    "exercises#edit" => :workout,
    "profiles#show" => :profile,
    "profiles#edit" => :profile
  }

  # Determine active tab based on current controller#action
  def active_tab
    TAB_MAPPING["#{controller_name}##{action_name}"] || :home
  end

  def tab_active?(tab)
    active_tab == tab
  end

  def active_link_class(tab)
    tab_active?(tab) ? "text-primary" : "text-gray-500 hover:text-primary-hover"
  end

  def back_path
    "javascript:history.back()"
  end

  private

  def fallback_tab_from_path
    path = request.path

    return :home if path == "/"

    return :workout if path.start_with?("/workouts")
    return :workout if path.start_with?("/routines")
    return :workout if path.start_with?("/exercises")

    return :profile if path.start_with?("/profile")

    :home
  end
end
