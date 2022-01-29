class ProjectPolicy < ApplicationPolicy

    class Scope < Scope
      def resolve
        scope.all
      end
    end
  
    def initialize(user, project)
      @user = user
      @project = project
    end
  
    def new?
      if @user.role == 'Manager'
        return true
      end
      false
    end
    def create?
      if @user.role =='Manager'
        return true
      end
      false
    end
  
  
    def update?
      if @user == @project.creator && @user.role == 'Manager'
        return true
      end
      false
    end
  
    def edit?
      if @user == @project.creator && @user.role =='Manager'
        return true
      end
      false
    end
  
    def delete?
      if @user == @project.creator && @user.Manager?
        return true
      end
      false
    end
    def can_create_bug?
  
      if @user.role == 'Quality' && @user.project_enrollment.include?(@project)
        return true
      end
      false
      end
  
  
  
  end
  