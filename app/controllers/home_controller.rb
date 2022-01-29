class HomeController < ApplicationController
  def index
    if current_user.Manager?
      @projects = current_user.projects.all
    else
      @projects = current_user.project_enrollment
    end
  end
end
