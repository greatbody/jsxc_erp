class M::ContactLogsController < MController
  before_action :authenticate_user!
  include SendNotifications

  def index
  end

  def new
    @contact_log = current_user.contact_logs.build
    @student = Student.find(params[:student_id])
  end

  def create
    user_id = current_user.id
    user_id = params[:contact_log][:user_id].to_i if params[:contact_log][:user_id].present?
    user = User.find(user_id)
    contact_log = user.contact_logs.build(new_contact_params)
    student_id = params[:student_id].to_i
    student = Student.find(student_id)
    contact_log.student = student
    if contact_log.save
      student.intention.update(next_contact_at: contact_log.next_contact_at, current_status: contact_log.current_status)

      student.update(signed_at: new_contact_params[:created_at]) if new_contact_params[:current_status] == 'signed_up' && contact_log.student.signed_at.nil?

      notify = {
        operator: user.name,
        message: "录入了【#{contact_log.student.name}】学员的一条新联系记录，状态变更为：#{I18n.t("current_status.#{contact_log.current_status}")}"
      }
      send_erp_notify(notify)

      redirect_to m_student_path(student)
    else
      redirect_to new_m_student_contact_log_path(student)
    end
  end

  def show
  end

  def edit
  end

  private

  def new_contact_params
    params.require(:contact_log).permit(:contact_type, :current_status, :need_contact, :next_contact_at, :contact_log, :created_at)
  end
end
