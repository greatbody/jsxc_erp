class M::StudentsController < MController
  before_action :authenticate_user!
  before_action :set_student, only: [:show, :edit]
  require 'phone_ext'
  include SendNotifications

  def index
    @intentions = Intention.where.not(current_status: 5).order(updated_at: :desc, next_contact_at: :asc)
  end

  def show
  end

  def edit
  end

  def query
    q = params[:q].to_s
    @intentions = Intention.joins(:student).where("`students`.`phone` LIKE ? OR `students`.`name` LIKE ?", "%#{q}%", "%#{q}%")
    @intentions = @intentions.where.not(current_status: 5).order(updated_at: :desc, next_contact_at: :asc)
    render '_student_list', layout: false
  end

  private

  def params_student
    params.require(:student).permit(:phone, :name, :sex, :address, :unit, :id_card, :coach_id, :is_local, :swift_number, :train_service_id, :process)
  end

  def set_student
    @student = Student.find(params[:id])
  end
end
