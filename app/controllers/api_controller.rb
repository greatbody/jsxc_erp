class ApiController < ApplicationController
  # accept request
  require 'authorize'
  include SendNotifications
  protect_from_forgery with: :null_session

  def notify
    if Authorize.verify?(params[:api])
      action_params = JSON.parse(params[:api][:content]).deep_symbolize_keys
      result = divide_task(action_params)
      render json: result
    else
      render html: 'error'
    end
  end

  private

  def divide_task(content)
    if content[:job].present?
      case content[:job]
      when 'appointment'
        appointment(content[:data])
      end
    end
  end

  def appointment(data)
    student = Student.new(student_params(data))
    intention = Intention.new(intention_params(data))
    intention.student = student
    if student.save && intention.save
      { error_code: '0', error_message: '' }
    else
      { error_code: '3', error_message: 'update error' }
    end
  end

  def intention_params(data)
    {
      source: '线上系统预约',
      current_status: 2,  # 预约试学
      next_contact_at: data[:appointment_date]
    }
  end

  def student_params(data)
    {
      phone: data[:phone], name: data[:name]
    }
  end
end
