# encoding: UTF-8
class ContactLogsController < ApplicationController
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
  end

  def create
    contact_log = current_user.contact_logs.build(new_contact_params)
    contact_log.student = Student.find(params[:student_id])
    if contact_log.save
      contact_log.student.intention.update(next_contact_at: contact_log.next_contact_at, current_status: contact_log.current_status)
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
    params.require(:contact_log).permit(:contact_type, :current_status, :need_contact, :next_contact_at, :contact_log)
  end

  # https://github.com/CanCanCommunity/cancancan/wiki/Strong-Parameters
  def create_params
    params.require(:contact_log).permit(:contact_type, :current_status, :need_contact, :next_contact_at, :contact_log)
  end
end
