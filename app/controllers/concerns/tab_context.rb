module TabContext
  extend ActiveSupport::Concern

  included do
    before_action :store_tab_context
  end

  private

  def store_tab_context
    return unless params[:tab].present?

    session[:active_tab] = params[:tab]
  end
end
