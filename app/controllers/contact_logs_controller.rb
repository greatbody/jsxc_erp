# encoding: UTF-8
class ContactLogsController < ApplicationController
  include SendNotifications
  before_action :authenticate_user!
  load_and_authorize_resource
  def index
  end

  def new_contact_log
    if request.method.downcase == 'post'
      redirect_to new_student_contact_log_path(params[:student_id])
    end
  end

  def new
    @current_page = :new_contact_log_path
    @contact_log = current_user.contact_logs.build
    @student = Student.find(params[:student_id])
  end

  def create
    user_id = current_user.id
    user_id = params[:contact_log][:user_id].to_i if params[:contact_log][:user_id].present?
    user = User.find(user_id)
    contact_log = user.contact_logs.build(new_contact_params)
    student_id = params[:student_id].to_i
    contact_log.student = Student.find(student_id)
    if contact_log.save
      contact_log.student.intention.update(next_contact_at: contact_log.next_contact_at, current_status: contact_log.current_status)

      contact_log.student.update(signed_at: new_contact_params[:created_at]) if new_contact_params[:current_status] == 'signed_up' && contact_log.student.signed_at.nil?

      notify = {
        operator: user.name,
        message: "录入了【#{contact_log.student.name}】学员的一条新联系记录，状态变更为：#{I18n.t("current_status.#{contact_log.current_status}")}"
      }
      send_erp_notify(notify)

      redirect_to intention_path(contact_log.student.intention)
    else
      redirect_to new_contact_log_path(contact_log.student)
    end
  end

  def edit
  end

  def show
  end

  private

  def new_contact_params
    params.require(:contact_log).permit(:contact_type, :current_status, :need_contact, :next_contact_at, :contact_log, :created_at)
  end

  # https://github.com/CanCanCommunity/cancancan/wiki/Strong-Parameters
  def create_params
    params.require(:contact_log).permit(:contact_type, :current_status, :need_contact, :next_contact_at, :contact_log)
  end
end
