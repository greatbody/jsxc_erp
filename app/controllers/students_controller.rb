# encoding: UTF-8
class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :get_student_status, :notify_got_number, :notify_got_card]
  load_and_authorize_resource
  def index
    @students = Student.all.order(signed_at: :desc)
  end

  def signed_up
    @students = Student.joins(:intention).where(intentions: {current_status: 4}).order(signed_at: :desc)
  end

  def wait_pay
    @students = Student.joins(:intention).where(intentions: {current_status: 3}).order(signed_at: :desc)
  end

  def new
  end

  def show
    @current_page = :student_path
    redirect_to root_path if @student.nil?
  end

  def edit
    @current_page = :edit_student_path
  end

  def update
    if @student.update(params_student)
      unless params_student[:coach_id].blank?
        coach = Coach.find(params_student[:coach_id])
        @student.update(coach: coach) if coach.present?
      end
      redirect_to student_path(@student)
    else
      redirect_to :back
    end
  end

  def get_student_status
    render html: '' if @student.nil?
    case @student.intention.current_status
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
    @student = Student.find(params_update_id_card[:student_id])
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

  def notify_got_number
    if @student.present?
      NotifyStudentJob.perform_later(@student.id, 'notify_got_number')
      render json: { msg_code: 'success' }
    else
      render json: { msg_code: 'error', msg_text: '学员不存在，请检查系统数据！' }
    end
  end

  def notify_got_card
    if @student.present?
      NotifyStudentJob.perform_later(@student.id, 'notify_got_card')
      render json: { msg_code: 'success' }
    else
      render json: { msg_code: 'error', msg_text: '学员不存在，请检查系统数据！' }
    end
  end

  private

  def params_update_id_card
    params.require(:student).permit(:id_card_pic, :id_card_back_pic, :student_id)
  end

  def params_student
    params.require(:student).permit(:phone, :name, :sex, :address, :unit, :id_card, :coach_id, :is_local, :swift_number, :train_service_id, :process)
  end

  def set_student
    @student = Student.find(params[:id])
  end
end
