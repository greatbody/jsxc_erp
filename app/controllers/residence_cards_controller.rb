# encoding: UTF-8
class ResidenceCardsController < ApplicationController
  before_action :set_residence_card, only: [:show, :edit, :update]
  def new
    @student = Student.find(params[:student_id])
    # unless @student.id_card_pic.present? && @student.id_card_back_pic.present?
    #   redirect_to edit_student_path(@student)
    # end
    @residence_card = ResidenceCard.new
  end

  def create
    @student = Student.find(params[:student_id])
    @residence_card = @student.residence_cards.build(residence_card_params)
    if @residence_card.save
      redirect_to @student, status: 302
    else
      redirect_to :back
    end
  end

  def show
  end

  def edit
  end

  def update
    if @residence_card.update(update_residence_card_params)
      redirect_to student_path(@residence_card.student), status: 302
    else
      redirect_to :back, alert: @residence_card.error_msg
    end
  end


  private

  def residence_card_params
    params.require(:residence_card).permit(:name, :gender, :current_status, :ethnicity, :process_by)
  end

  def update_residence_card_params
    params.require(:residence_card).permit(:name, :gender, :current_status, :ethnicity, :process_by)
  end

  def set_residence_card
    @residence_card = ResidenceCard.find(params[:id])
  end
end
