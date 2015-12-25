# encoding: UTF-8
class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :get_student_status, :update_id_card]
  def index
  end

  def new
  end

  def show
    redirect_to root_path if @student.nil?
  end

  def edit
    @current_page = :edit_student_path
  end

  def update
    if @student.update(params_student)
      coach = Coach.find(params_student[:coach_id])
      @student.update(coach: coach) if coach.present?
      redirect_to student_path(@student)
    else
      redirect_to :back
    end
  end

  def get_student_status
    render html: '' if @student.nil?
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

  def update_id_card
    upload_param = params_update_id_card
    @error_code = '学员不存在' if @student.nil?
    if upload_param[:id_card_pic].present?
      @student.update(id_card_pic: upload_param[:id_card_pic])
      @render_url = @student.id_card_pic.url
    elsif upload_param[:id_card_back_pic].present?
      @student.update(id_card_back_pic: upload_param[:id_card_back_pic])
      @render_url = @student.id_card_back_pic.url
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def is_number? string
    true if Float(string) rescue false
  end

  def params_update_id_card
    params.require(:student).permit(:id_card_pic, :id_card_back_pic, :student_id)
  end

  def params_student
    params.require(:student).permit(:phone, :name, :sex, :address, :unit, :id_card, :coach_id)
  end

  def set_student
    @student = Student.find(params[:id])
  end
end
