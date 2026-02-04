module NavigationHelper
  def active_tab
    return session[:active_tab].to_sym if session[:active_tab].present?

    fallback_tab_from_path
  end

  def tab_active?(tab)
    active_tab == tab
  end

  def active_link_class(tab)
    tab_active?(tab) ? "text-primary" : "text-gray-500 hover:text-primary-hover"
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
