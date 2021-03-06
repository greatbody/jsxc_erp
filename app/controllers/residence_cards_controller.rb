# encoding: UTF-8
class ResidenceCardsController < PcApplicationController
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
    unless @residence_card.current_status == update_residence_card_params[:current_status]
      current_time = Time.now
      case update_residence_card_params[:current_status]
      when 'id_card_received'
        @residence_card.update(id_card_received_at: current_time)
      when 'id_card_returned'
        @residence_card.update(id_card_returned_at: current_time)
      when 'have_number'
        @residence_card.update(have_number_at: current_time)
      when 'have_card'
        @residence_card.update(have_card_at: current_time)
      when 'return_card'
        @residence_card.update(return_card_at: current_time)
      when 'applyed'
        @residence_card.update(applyed_at: current_time)
      end
    end
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
