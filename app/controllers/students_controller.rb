# encoding: UTF-8
class StudentsController < ApplicationController
  def index
  end

  def new
  end

  def show
    id = params[:id].to_i
    redirect_to root_path if id <= 0
    @student = Student.find(id)
    redirect_to root_path if @student.nil?
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
