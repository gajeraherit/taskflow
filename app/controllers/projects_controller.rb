class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_workspace
  before_action :set_project, only: [:show]

  def index
    @projects = @workspace.projects
  end

  def show
    @tasks_todo = @project.tasks.where(status: "todo")
    @tasks_in_progress = @project.tasks.where(status: "in_progress")
    @tasks_done = @project.tasks.where(status: "done")
  end

  def new
    @project = Project.new
  end

  def create
    @project = @workspace.projects.new(project_params)
    @project.user = current_user

    if @project.save
      redirect_to workspace_project_path(@workspace, @project), notice: "Project created successfully!"
    else
      render :new
    end
  end

  private

  def set_workspace
    @workspace = current_user.workspaces.find(params[:workspace_id])
  end

  def set_project
    @project = @workspace.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end
end