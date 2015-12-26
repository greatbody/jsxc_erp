# encoding: UTF-8
class ServiceController < ApplicationController
  before_action :authenticate_user!
  def assign_task
    student_id = params[:student_id]
    processor_id = params[:processor_id]
    sender_id = current_user.id
    task_type = params[:task_type]
    if student_id.blank? || processor_id.blank?
      render json: { msg_code: 'error', msg_text: '未指定学员或处理人' }
    else
      AssignTaskJob.perform_later(student_id, processor_id, sender_id, task_type)
      render json: { msg_code: 'success', msg_text: '' }
    end
  end
end
