# encoding: UTF-8
class StudentsController < ApplicationController
  def index
  end

  def new
  end

  def show
    @current_page = :student_path
    id = params[:id].to_i
    redirect_to root_path if id <= 0
    @student = Student.find(id)
    redirect_to root_path if @student.nil?
  end

  def edit
    @current_page = :edit_student_path
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])
    if @student.update(params_student)
      redirect_to student_path(@student)
    else
      redirect_to :back
    end
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

  def update_id_card
    upload_param = params_update_id_card
    @error_code = '学员不存在' if upload_param[:student_id].to_i == 0
    @student = Student.find(upload_param[:student_id])
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
    params.require(:student).permit(:phone, :name, :sex, :address, :unit, :id_card)
  end
end
