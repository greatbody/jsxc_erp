# encoding: UTF-8
class ResidenceCardsController < ApplicationController
  def new
    @student = Student.find(params[:student_id])
    # unless @student.id_card_pic.present? && @student.id_card_back_pic.present?
    #   redirect_to edit_student_path(@student)
    # end
    @residence_card = ResidenceCard.new
  end

  def create
    @student = Student.find(params[:student_id])
    @residence_card = @student.residence_cards.build(residence_card_param)
    if @residence_card.save
      redirect_to @student, status: 302
    else
      redirect_to :back
    end
  end

  def edit
  end

  def show
  end

  private

  def residence_card_param
    params.require(:residence_card).permit(:name, :gender, :current_status, :ethnicity, :process_by)
  end
end
