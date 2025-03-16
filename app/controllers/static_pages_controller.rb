class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    # This is the landing page for non-authenticated users
    redirect_to dashboard_path if user_signed_in?
  end
end
