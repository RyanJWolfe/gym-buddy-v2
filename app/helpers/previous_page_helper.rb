module PreviousPageHelper
  def path_to_previous_page
    return session[:previous_pages].first if session[:previous_pages].present? && session[:previous_pages].size > 1

    root_path
  end
end
