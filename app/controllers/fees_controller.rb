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

  def new_exams
    @student_id = params[:student_id]
    @student = Student.find(@student_id)

    @student.fees.build({ amount: 120, fee_type: 'kaoshi', fee_mode: 'zhichu', remark: "#{@student.name} 的科目一考试费" }).save
    @student.fees.build({ amount: 150, fee_type: 'kaoshi', fee_mode: 'zhichu', remark: "#{@student.name} 的科目二考试费" }).save
    @student.fees.build({ amount: 240, fee_type: 'kaoshi', fee_mode: 'zhichu', remark: "#{@student.name} 的科目三及制证费" }).save

    @fees = @student.fees
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
