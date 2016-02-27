class WorkTasksController < ApplicationController
  before_action :set_task, only: [:show, :edit]
  before_action :authenticate_user!
  protect_from_forgery with: :null_session
  def index
    @tasks = WorkTask.where(to_user_id: current_user.id, status: 1)
    @other_tasks = WorkTask.where.not(to_user_id: current_user.id)
    @done_tasks = WorkTask.where(to_user_id: current_user.id, status: 2)
  end

  def new
  end

  def show
    @task.update(is_read: true) unless @task.is_read?
  end

  def edit
  end

  def process_task
    action_type = params[:action_type]
    task_id = params[:task_id]
    task = WorkTask.find(task_id)
    case action_type
    when 'finish'
      task.done!
      task.work_task_steps.build(params_for_finish).save
      render json: { msg_code: 'success', msg_text: '' }
    when 'activate'
      task.active!
      task.work_task_steps.build(params_for_activate).save
      render json: { msg_code: 'success', msg_text: '' }
    when 'close'
      task.close!
      task.work_task_steps.build(params_for_close).save
      render json: { msg_code: 'success', msg_text: '' }
    else
      render json: { msg_code: 'error', msg_text: '无效操作！' }
    end
  end

  private

  def set_task
    @task = WorkTask.find(params[:id])
    # @task_steps = @task.work_task_steps.order(created_at: :desc)
  end

  def params_for_finish
    {
      operation: 2,
      operate_user_id: current_user.id,
      remarks: '【无】',
      html: '<b>完成</b>'
    }
  end

  def params_for_activate
    {
      operation: 1,
      operate_user_id: current_user.id,
      remarks: '【无】',
      html: '<b>完成</b>'
    }
  end

  def params_for_close
    {
      operation: 0,
      operate_user_id: current_user.id,
      remarks: '【无】',
      html: '<b>完成</b>'
    }
  end
end
