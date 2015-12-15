class StudentsController < ApplicationController
  def index
  end

  def new
  end

  def show
  end

  def edit
  end

  def get_student_status
    id = params[:id]
    render html: '' if !is_number?(id)
    id = id.to_i
    student = Student.find(id)
    render html: '' if student.nil?
    case student.intention.current_status
    when 'wait_call'
      render html: 'intent'
    when 'contacting'
      render html: 'intent'
    when 'booking'
      render html: 'trylearn'
    when 'wait_pay'
      render html: 'sign_up'
    when 'signed_up'
      render html: 'complaint'
    end
  end

  private

  def is_number? string
    true if Float(string) rescue false
  end
end
