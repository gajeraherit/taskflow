class WorkspacesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_workspace, only: [:show]

  def index
    @workspaces = current_user.workspaces.includes(:workspace_memberships)
    @workspaces = @workspaces.to_a
  end

  def show
  end

  def new
    @workspace = Workspace.new
  end

  def create
    @workspace = Workspace.new(workspace_params)
    @workspace.owner = current_user

    if @workspace.save
      WorkspaceMembership.create(
        user: current_user,
        workspace: @workspace,
        role: "owner"
      )
      redirect_to @workspace, notice: "Workspace created successfully!"
    else
      render :new
    end
  end

  private

  def set_workspace
    @workspace = current_user.workspaces.find(params[:id])
  end

  def workspace_params
    params.require(:workspace).permit(:name)
  end
end