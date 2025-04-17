class Admin::DashboardController < ApplicationController
  before_action :require_admin!

  def index
    @clients = Client.all.includes(:projects)
    @projects = Project.all.includes(:client, :requirements)
    @users = User.all.includes(:client)

    @total_clients = @clients.count
    @total_projects = @projects.count
    @total_requirements = Requirement.count
    @active_projects = @projects.where(status: :active).count
  end
end
