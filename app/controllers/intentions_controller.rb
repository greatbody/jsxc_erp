# encoding: UTF-8
class IntentionsController < PcApplicationController
  require 'phone_ext'
  require 'ext_calc'
  include SendSms
  include SendNotifications

  before_action :authenticate_user!
  load_and_authorize_resource
  def index
    @current_page = :intentions_path
    @intentions = Intention.all.order(updated_at: :desc, next_contact_at: :asc)
    if current_user.has_role? :jby
      @intentions = @intentions.joins(:student).where(students: { identity: 2 })
    end
    @today_intentions = @intentions.where('(next_contact_at <= ? or next_contact_at is null) and (current_status != 4 and current_status != 5)', Date.today)
  end

  def new
    @student = current_user.students.build
    @student.build_intention
  end

  def create
    user_id = current_user.id
    user_id = params[:student][:contact_log][:user_id].to_i if params[:student][:contact_log][:user_id].present?
    user = User.find(user_id)
    @student = user.students.build(params_of_student)
    @student.intention.user = @student.user
    if current_user.has_role? :jby
      @student.jby!
    end
    can_update_last_contact = (params[:student][:contact_log][:has_contact_log] == '1')
    student_source_id = params[:student][:student_source][:id]
    if can_update_last_contact
      #save contact log attactched to it
      contact_log_entity = user.contact_logs.build(params_of_contact_log_in_student)
      @student.contact_logs << contact_log_entity
    else
      contact_log_entity = user.contact_logs.build(default_contact_log)
      @student.contact_logs << contact_log_entity
    end
    if @student.save
      if can_update_last_contact
        @student.intention.update(next_contact_at: contact_log_entity.next_contact_at, current_status: contact_log_entity.current_status)
        @student.update(signed_at: Date.today) if params_of_contact_log_in_student[:current_status] == 'signed_up' && @student.signed_at.nil?
        @student.update(signed_at: nil) if params_of_contact_log_in_student[:current_status] == 'canceled'
      else
        @student.intention.update(next_contact_at: Date.today, current_status: 0)
      end

      if student_source_id.is_number?
        student_source = StudentSource.find(student_source_id)
        @student.intention.student_source = student_source
      else
        @student.intention.student_source = nil
      end

      notify = {
        operator: user.name,
        message: "创建了【#{@student.name}】学员，并录入了他（她）的意向信息"
      }
      send_erp_notify(notify)

      respond_to do |format|
        format.html { redirect_to root_path }
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, alert: @student.errors.messages.values.first.try(&:first) }
      end
    end
  end

  def show
    @current_page = :intention_path
    id = params[:id].to_i
    @intention = Intention.find(id)
    @student = @intention.student
    @contact_logs = @student.contact_logs.order(created_at: :desc)
  end

  def get_intention_list
    current_status = params[:current_status]
    @intentions = Intention.all
    if current_user.has_role? :jby
      @intentions = @intentions.joins(:student).where(students: { identity: 2 })
    end
    case current_status.downcase
    when 'wait_call'
      @intentions = @intentions.wait_call
    when 'contacting'
      @intentions = @intentions.contacting
    when 'booking'
      @intentions = @intentions.booking
    when 'wait_pay'
      @intentions = @intentions.wait_pay
    when 'signed_up'
      @intentions = @intentions.signed_up
    when 'should_contact'
      @intentions = @intentions.where('(next_contact_at <= ? or next_contact_at is null) and (current_status != 5)', Date.today)
    end
    @intentions = @intentions.order(updated_at: :desc, next_contact_at: :asc)
    render '_index_card_intention_list', layout: false
  end

  def edit
    @current_page = :edit_intention_path
    @intention = Intention.find(params[:id])
  end

  def update
    student_source_id = params[:intention][:student_source][:id]
    @intention = Intention.find(params[:id])

    @intention.update(params_of_intention_update)
    if student_source_id.is_number?
      @intention.student_source = StudentSource.find(student_source_id)
    else
      @intention.student_source = nil
    end
    @intention.save
    notify = {
      operator: current_user.name,
      message: "更新了【#{@intention.student.name}】学员的意向信息"
    }
    send_erp_notify(notify)
    redirect_to @intention
  end

  private

  def params_of_student
    params.require(:student).permit(:name, :sex, :phone, :id_card, :address, :unit, intention_attributes: [:source])
  end

  def params_of_intention_update
    params.require(:intention).permit(:source, :current_status)
  end

  def params_of_contact_log_in_student
    params.require(:student).require(:contact_log).permit(:contact_type, :current_status, :need_contact, :next_contact_at, :contact_log, :created_at)
  end

  def default_contact_log
    {
      contact_type: 'intent',
      current_status: 'wait_call',
      need_contact: 1,
      next_contact_at: Date.today,
      contact_log: ''
    }
  end

end
