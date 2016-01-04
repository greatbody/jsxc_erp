# encoding: UTF-8
class IntentionsController < ApplicationController
  require 'phone_ext'
  include SendSms
  before_action :authenticate_user!
  load_and_authorize_resource
  def index
    @current_page = :intentions_path
    @intentions = Intention.all.order(updated_at: :desc, next_contact_at: :asc)
  end

  def new
    @student = current_user.students.build
    @student.build_intention
  end

  def create
    @student = current_user.students.build(params_of_student)
    @student.intention.user = @student.user
    can_update_last_contact = (params[:student][:contact_log][:has_contact_log] == '1')
    if can_update_last_contact
      #save contact log attactched to it
      contact_log_entity = current_user.contact_logs.build(params_of_contact_log_in_student)
      @student.contact_logs << contact_log_entity
    else
      contact_log_entity = current_user.contact_logs.build(default_contact_log)
      @student.contact_logs << contact_log_entity
    end
    if @student.save
      if can_update_last_contact
        @student.intention.update(next_contact_at: contact_log_entity.next_contact_at, current_status: contact_log_entity.current_status)
      else
        @student.intention.update(next_contact_at: Date.today, current_status: 0)
      end
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
    when 'should_contact'
      @intentions = Intention.where('(next_contact_at <= ? or next_contact_at is null) and (current_status != 4 and current_status != 5)', Date.today)
    end
    @intentions = @intentions.order(updated_at: :desc, next_contact_at: :asc)
    render '_index_card_intention_list', layout: false
  end

  def edit
    @current_page = :edit_intention_path
    @intention = Intention.find(params[:id])
  end

  def update
    @intention = Intention.find(params[:id])
    @intention.update(params_of_intention_update)
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
    params.require(:student).require(:contact_log).permit(:contact_type, :current_status, :need_contact, :next_contact_at, :contact_log)
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
