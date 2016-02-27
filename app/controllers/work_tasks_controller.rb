class WorkTasksController < ApplicationController
  def index
    @tasks = WorkTask.where(to_user_id: current_user.id, status: 1)
  end

  def new
  end

  def show
  end

  def edit
  end
end
