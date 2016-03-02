class M::IntentionsController < MController
  before_action :authenticate_user!
  include SendNotifications

  def index
  end

  def new
    @student = current_user.students.build
    @student.build_intention
  end

  def create
    # get user
    user = current_user
    # build student of user
    @student = user.students.build(params_of_student)
    # bind intention user to student.user
    @student.intention.user = @student.user
    # pick student_source_id
    student_source_id = params[:student][:student_source][:id]
    # build default contact log
    contact_log_entity = user.contact_logs.build(default_contact_log)
    @student.contact_logs << contact_log_entity

    if @student.save
      @student.intention.update(next_contact_at: Date.today, current_status: 0)
      # bind student_source for intention
      if student_source_id.is_number?
        student_source = StudentSource.find(student_source_id)
        @student.intention.student_source = student_source
      else
        @student.intention.student_source = nil
      end

      notify = {
        operator: user.name,
        message: "通过手机创建了【#{@student.name}】学员，并录入了他（她）的意向信息"
      }
      send_erp_notify(notify)

      respond_to do |format|
        format.html { redirect_to m_student_path(@student) }
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, alert: @student.errors.messages.values.first.try(&:first) }
      end
    end
  end

  def show
  end

  def edit
  end

  private

  def params_of_student
    params.require(:student).permit(:name, :sex, :phone, :id_card, :address, :unit, intention_attributes: [:source])
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
