   
class BugPolicy < ApplicationPolicy
    class Scope < Scope
      def resolve
        scope.all
      end
    end
    def initialize(user, bug)
      @user = user
      @bug = bug
    end
  
    def new?
      if @user.role == 'Quality' && @user.project_enrollment.include?(@bug.project)
        return true
      end
      false
    end
    def create?
      if @user.role == 'Quality' && @user.project_enrollment.include?(@bug.project)
        return true
      end
      false
    end
    def edit?
      return true if @bug.created_by == @user
      false
    end
    def update?
      if  (@user.Developer? && @user.project_enrollment.include?(@bug.project)) || @bug.creator == @user
        return true
      end
      false
    end
  
    # @return [Object]
    def delete?
      if @bug.created_by == @user
        return true
      end
      false
    end
  
  end