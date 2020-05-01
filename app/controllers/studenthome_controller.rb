class StudenthomeController < ApplicationController
  #authorizes user
  before_action :authorized?
  private def authorized?
    unless current_user.admin? || !current_user.teacher?
      # go to previous page before request, backup is home page
      redirect_back(fallback_location: root_path)
    end
  end

  def index
    @user = current_user
  end
end
