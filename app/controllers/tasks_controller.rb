class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_workspace
  before_action :set_project
  before_action :set_task, only: [:edit, :update, :destroy]

  def new
    @task = Task.new
  end

  def edit
  end

 def create
  @task = @project.tasks.new(task_params)
  @task.user = current_user

  if @task.save
    TaskMailer.task_assigned(@task).deliver_now
    redirect_to workspace_project_path(@workspace, @project), notice: "Task created successfully!"
  else
    render :new
  end
end

  def update
    if @task.update(task_params)
      redirect_to workspace_project_path(@workspace, @project), notice: "Task updated!"
    else
      redirect_to workspace_project_path(@workspace, @project), alert: "Something went wrong!"
    end
  end

  def destroy
    @task.destroy
    redirect_to workspace_project_path(@workspace, @project), notice: "Task deleted!"
  end

  private

  def set_workspace
    @workspace = current_user.workspaces.find(params[:workspace_id])
  end

  def set_project
    @project = @workspace.projects.find(params[:project_id])
  end

  def set_task
    @task = @project.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :status, :priority, :due_date)
  end
end