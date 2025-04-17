class DashboardController < ApplicationController
  def index
    @recent_projects = Project.includes(:client).order(created_at: :desc).limit(5)
    @active_projects = Project.includes(:client).where(status: [:active, :in_progress]).order(updated_at: :desc)
    @pending_requirements = Requirement.includes(:project)
                                    .where(project_id: @active_projects.pluck(:id))
                                    .order(created_at: :desc)
    @project_stats = {
      total: Project.count,
      active: Project.where(status: [:active, :in_progress]).count,
      completed: Project.where(status: :completed).count
    }
  end
end
