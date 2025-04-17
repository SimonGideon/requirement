class Client::ProjectsController < ApplicationController
  before_action :require_client!
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :set_client

  def index
    @projects = @client.projects.includes(:requirements).order(created_at: :desc)
  end

  def show
    @requirements = @project.requirements.order(priority: :desc)
  end

  def new
    @project = @client.projects.build
  end

  def create
    @project = @client.projects.build(project_params)
    @project.status = :draft

    if @project.save
      redirect_to client_project_path(@project), notice: 'Project was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to client_project_path(@project), notice: 'Project was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    redirect_to client_projects_path, notice: 'Project was successfully deleted.'
  end

  private

  def set_project
    @project = @client.projects.find(params[:id])
  end

  def set_client
    @client = current_user.client
    redirect_to root_path, alert: 'Client not found' unless @client
  end

  def project_params
    params.require(:project).permit(
      :title,
      :description,
      :desired_completion_date,
      :requirements_document,
      requirements_attributes: [
        :id,
        :title,
        :description,
        :priority,
        :category,
        :must_have,
        :acceptance_criteria,
        :_destroy
      ]
    )
  end
end 