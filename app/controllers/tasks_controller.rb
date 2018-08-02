# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_current_task_user,
                only: %i[edit update destroy complete take]

  def new
    @task = current_user.created_tasks.build
  end

  def create
    @task = current_user.created_tasks.build(task_params)

    if @task.save
      redirect_to authenticated_root_path, notice: 'You created new task'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to current_user, notice: 'Successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy

    redirect_back(fallback_location: authenticated_root_path,
                  notice: 'Task deleted')
  end

  def complete
    @task = Task.find(params[:id])
    @task.complete

    redirect_to authenticated_root_path, notice: 'You has finished task'
  end

  def take
    @task = Task.find(params[:id])
    @task.take

    redirect_to authenticated_root_path, notice: 'Lets work!'
  end

  private

  def set_current_task_user
    @task = current_user.assigned_tasks.find_by(id: params[:id])

    redirect_back(fallback_location: authenticated_root_path) unless @task
  end

  def task_params
    params.require(:task).permit(:title, :description, :assignee_id)
  end
end
