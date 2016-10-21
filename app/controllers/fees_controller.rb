class FeesController < ApplicationController
  before_action :authenticate_user!
  def index
    @current_page = :fees_path
    Fee.connection.execute('update fees set is_done = true where amount = total_paid and is_done = false')
    @fees = Fee.all
  end

  def new
    @student_id = params[:student_id]
    respond_to do |format|
      format.js
    end
  end

  def create
    @student = Student.find(params[:student_id])
    @fee = @student.fees.build(fee_params)
    if @fee.save
      respond_to do |format|
        format.json { render json: { error_code: '0' } }
      end
    else
      respond_to do |format|
        format.json { render json: { error_code: '1' } }
      end
    end
  end

  def show
  end

  def edit
  end

  private

  def fee_params
    params.permit(:amount, :fee_type, :fee_mode, :remark)
  end
end
