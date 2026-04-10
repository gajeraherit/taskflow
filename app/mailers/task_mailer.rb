class TaskMailer < ApplicationMailer
  def task_assigned(task)
    @task = task
    @project = task.project
    @workspace = @project.workspace
    @user = task.user

    mail(
      to: @user.email,
      subject: "New task assigned: #{@task.title}"
    )
  end
end