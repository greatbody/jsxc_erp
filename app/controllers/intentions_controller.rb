class IntentionsController < ApplicationController
  require 'phone_ext'
  before_action :authenticate_user!
  def index
    @intentions = Intention.all.order(next_contact_at: :desc)
  end

  def new
    @student = current_user.students.build
    @student.build_intention
  end

  def create
    @student = current_user.students.build(params_of_student)
    @student.intention.user = @student.user
    if params[:student][:contact_log][:has_contact_log] == '1'
      #save contact log attactched to it
      contact_log_entity = current_user.contact_logs.build(params_of_contact_log_in_student)
      @student.contact_logs << contact_log_entity
    end
    if @student.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Account created successfully." }
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, alert: @student.errors.messages.values.first.try(&:first) }
      end
    end
  end

  def show
    id = params[:id].to_i
    @intention = Intention.find(id)
    @student = @intention.student
    @contact_logs = @student.contact_logs.order(created_at: :desc)
  end

  def get_intention_list
    current_status = params[:current_status]
    @intentions = Intention.all
    case current_status.downcase
    when 'all'
      @intentions = Intention.all
    when 'wait_call'
      @intentions = Intention.wait_call
    when 'contacting'
      @intentions = Intention.contacting
    when 'booking'
      @intentions = Intention.booking
    when 'wait_pay'
      @intentions = Intention.wait_pay
    when 'signed_up'
      @intentions = Intention.signed_up
    end
    @intentions = @intentions.order(next_contact_at: :desc)
    render '_index_intention_list', layout: false
  end

  def edit
  end

  private

  def params_of_student
    params.require(:student).permit(:name, :sex, :phone, :id_card, :address, :unit, intention_attributes: [:source])
  end

  def params_of_contact_log_in_student
    params.require(:student).require(:contact_log).permit(:contact_type, :current_status, :need_contact, :next_contact_at, :contact_log)
  end

end
