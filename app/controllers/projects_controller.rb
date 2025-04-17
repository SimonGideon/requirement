def public_show
  # This is the client-facing page
  @requirements = @project.requirements.order(priority: :desc)
  @attachments = @project.attachments.order(created_at: :desc)
  @new_requirement = @project.requirements.build
  @new_attachment = @project.attachments.build
  
  render layout: 'public'
end

def public_update
  # Handle client submission
  if @project.update(project_public_params)
    @project.submitted! unless @project.submitted?
    redirect_to public_project_path(@project), notice: "Thank you for submitting your requirements!"
  else
    @requirements = @project.requirements.order(priority: :desc)
    @attachments = @project.attachments.order(created_at: :desc)
    @new_requirement = @project.requirements.build
    @new_attachment = @project.attachments.build
    
    render :public_show, layout: 'public', status: :unprocessable_entity
  end
end

private

def project_public_params
  params.require(:project).permit(:notes, requirements_attributes: [:id, :title, :description, :priority, :category, :must_have, :acceptance_criteria, :_destroy])
end