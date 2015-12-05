class IntentionsController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def new
    @student = current_user.students.build
    @student.build_intention
  end

  def create
    @student = Student.new(params_of_student)
    if @student.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Account created successfully." }
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

end
