class ContactLogsController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def new
    @contact_log = current_user.contact_logs.build
  end

  def create
    contact_log = current_user.contact_logs.build(new_contact_params)
    contact_log.student = Student.find(params[:contact_log][:student])
    if contact_log.save
      contact_log.student.intention.update(next_contact_at: contact_log.next_contact_at)
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
end
