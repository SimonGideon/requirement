class Client::DashboardController < ApplicationController
  before_action :require_client!
  before_action :set_client

  def index
    @projects = @client.projects.includes(:requirements)
    @active_projects = @projects.where(status: 1) # Using integer value for active status
    @completed_projects = @projects.where(status: 2) # Using integer value for completed status
  end

  private

  def set_client
    @client = current_user.client
    redirect_to root_path, alert: 'Client not found' unless @client
  end
end 