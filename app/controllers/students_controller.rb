# encoding: UTF-8
class StudentsController < PcApplicationController
  before_action :set_student, only: [:show, :edit, :update, :get_student_status, :notify_got_number, :notify_got_card, :update_km1]
  before_action :set_exam_record, only: [:update_km]
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
    if @student.nil?
      redirect_to root_path
    else
      @km1 = @student.current_km1
    end
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

  def peek_before_evaluation
    student = Student.find(params[:id])
    if student.present?
      # 存在学员
      if student.last_evaluation_by == current_user.name
        # 上次自己更改的
        render json: { msg_code: 'success' }
      else
        # 上次他人更改的
        if student.last_evaluation_by.blank?
          render json: { msg_code: 'success' }
        else
          if (Time.zone.now - student.updated_at).abs < 100
            render json: { msg_code: 'error', msg_text: "刚才#{student.last_evaluation_by}编辑了，是否覆盖？" }
          else
            render json: { msg_code: 'success' }
          end
        end
      end
    else
      # 学员不存在
      render json: { msg_code: 'error', msg_text: '学员不存在，请检查系统数据！' }
    end
  end

  def update_evaluation
    student = Student.find(params[:id])
    if student.update(evaluation: params[:evaluation], last_evaluation_by: current_user.name)
      render json: { msg_code: 'success' }
    else
      render json: { msg_code: 'error', msg_text: '更新错误，请联系18771024287！' }
    end
  end

  def update_km1
    value = params[:km1_status]
    if @student.update(km1_status: value)
      render json: { msg_code: 'success' }
    else
      render json: { msg_code: 'error', msg_text: '更新错误，请联系18771024287！' }
    end
  end

  def update_km
    if @exam_record.update(params_update_km)
      render json: { msg_code: 'success' }
    else
      render json: { msg_code: 'error', msg_text: '更新错误，请联系18771024287！' }
    end
  end

  private

  def params_update_id_card
    params.require(:student).permit(:id_card_pic, :id_card_back_pic, :student_id)
  end

  def params_student
    params.require(:student).permit(:phone, :name, :sex, :address, :unit, :id_card, :coach_id, :is_local, :swift_number, :train_service_id, :process, :qq, :weixin, :is_local_phone, :is_slow, :is_unlocked, :is_trained)
  end

  def params_update_km
    params.require(:data).permit(:kemu, :kc_names, :begin_match_at, :end_match_at, :kc_name, :ks_at, :ks_cc, :status)
  end

  def set_student
    @student = Student.find(params[:id])
  end

  def set_exam_record
    @exam_record = ExamRecord.find(params[:data][:id])
  end
end
