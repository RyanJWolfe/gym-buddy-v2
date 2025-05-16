module NavbarHelper
  def navigation_links
    [
      { title: 'Dashboard', url: dashboard_path, active: current_page?(root_path || dashboard_path) },
      { title: 'Workouts', url: workouts_path, active: controller_name == 'workouts' },
      { title: 'Exercises', url: exercises_path, active: controller_name == 'exercises' }
    ]
  end
end
