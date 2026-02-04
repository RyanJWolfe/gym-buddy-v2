module TabContext
  extend ActiveSupport::Concern

  included do
    # before_action :set_active_tab
    # before_action :store_last_tab_path
  end

  private

  # def set_active_tab
  #   return unless params[:tab].present?
  #
  #   return if prefetch_request?
  #
  #   session[:active_tab] = params[:tab]
  # end

  def store_last_tab_path
    return unless session[:active_tab].present?

    return if prefetch_request? || request.method != "GET"

    tab = session[:active_tab]

    session[:tabs] ||= {}

    session[:tabs][tab] ||= {}
    session[:tabs][tab][:last_path] = request.fullpath
    session[:tabs][tab][:last_tap] = Time.current
  end

  def prefetch_request?
    request.headers["HTTP_X_SEC_PURPOSE="] == "prefetch"
  end
end
