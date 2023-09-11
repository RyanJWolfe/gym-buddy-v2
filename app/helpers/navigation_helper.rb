# frozen_string_literal: true

module NavigationHelper
  def navigation_links
    [
      { title: 'Home', url: root_path, active: current_page?(root_path) },
    ]
  end
end
