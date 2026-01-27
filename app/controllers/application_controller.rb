class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_active_workout

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name ])
  end

  def set_active_workout
    return unless user_signed_in?

    @active_workout ||= current_user.workouts.where(status: :in_progress).first
  end

  def remember_page
    session[:previous_pages] ||= []
    new_page = url_for(params.to_unsafe_h)
    return unless session[:previous_pages].last != new_page

    session[:previous_pages] << new_page if request.get?
    session[:previous_pages] = session[:previous_pages].last(2)
  end

  def hide_bottom_nav
    @hide_bottom_nav = true
  end
end
