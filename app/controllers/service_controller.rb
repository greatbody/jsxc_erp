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

  def search
    q = params[:q].to_s
    items = []
    intentions = Intention.where("source LIKE ?", "%#{q}%")
    students = Student.where("phone LIKE ? OR name LIKE ?", "%#{q}%", "%#{q}%")
    intentions.each do |intention|
      items << {
        business: '意向信息',
        name: "#{intention.student.name}",
        html_url: "/intentions/#{intention.id}",
        description: ''
      }
    end

    students.each do |student|
      items << {
        business: '学员信息',
        name: "#{student.name}",
        html_url: "/students/#{student.id}",
        description: ''
      }
    end
    render json: { items: items }
  end
end
