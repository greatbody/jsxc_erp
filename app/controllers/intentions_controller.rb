class IntentionsController < ApplicationController
  before_action :authenticate_user!
  def index
    @intentions = Intention.all
  end

  def new
    @student = current_user.students.build
    @student.build_intention
  end

  def create
    @student = Student.new(params_of_student)
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
  end

  def edit
  end

  private
  def params_of_student
    params.require(:student).permit(:name, :sex, :phone, :id_card, :address, :unit, intention_attributes: [:source])
  end

end
