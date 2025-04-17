class DashboardController < ApplicationController
  def index
    @recent_projects = Project.includes(:client).order(created_at: :desc).limit(5)
    @active_projects = Project.includes(:client).where("status = ?", 1).order(updated_at: :desc)
    @pending_requirements = Requirement.includes(:project)
                                    .where(project_id: @active_projects.pluck(:id))
                                    .order(created_at: :desc)
    @project_stats = {
      total: Project.count,
      active: Project.where("status = ?", 1).count,
      completed: Project.where("status = ?", 2).count
    }
  end
end
