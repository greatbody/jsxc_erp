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
    if @student.save
      respond_to do |format|
        format.html { redirect_to intentions_path, notice: "Account created successfully." }
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

end
