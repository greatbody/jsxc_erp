# encoding: UTF-8
class ResidenceCardsController < ApplicationController
  before_action :set_residence_card, only: [:show, :edit, :update]
  def new
    @current_page = :new_student_residence_card_path
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
      # update student id_card if empty
      @student.update(id_card: residence_card_params[:id_card]) if @student.id_card.blank?
      redirect_to @student, status: 302
    else
      redirect_to :back
    end
  end

  def show
  end

  def edit
    @current_page = :edit_student_residence_card_path
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
    params.require(:residence_card).permit(:name, :gender, :current_status, :ethnicity, :process_by, :id_card, :current_address)
  end

  def update_residence_card_params
    params.require(:residence_card).permit(:name, :gender, :current_status, :ethnicity, :process_by, :card_id, :id_card, :current_address)
  end

  def set_residence_card
    @residence_card = ResidenceCard.where("id = ?", params[:id]).first
    redirect_to intentions_path if @residence_card.nil?
  end
end
