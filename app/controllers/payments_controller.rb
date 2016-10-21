class PaymentsController < ApplicationController
  def index
  end

  def new
    @student_id = params[:student_id]
    @fee_id = params[:fee_id]
    @student = Student.find(@student_id)
    @fee = Fee.find(@fee_id)
    # 收入学员费用
    if @fee.shouru?
      if @fee.baoming?
        @name = "收入#{@student.name}报名费（#{@fee.amount - @fee.total_paid}）"
      elsif @fee.kaoshi?
        @name = "收入#{@student.name}考试费（#{@fee.amount - @fee.total_paid}）"
      else
        @name = "收入#{@student.name}缴费（#{@fee.amount - @fee.total_paid}）"
      end
    else
      if @fee.kaoshi?
        @name = "支出#{@student.name}的考试费（#{@fee.amount - @fee.total_paid}）"
      else
        @name = "支出#{@student.name}的费用（#{@fee.amount - @fee.total_paid}）"
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def create
    fail_count = 0
    @fee = Fee.find(params[:fee_id])
    @payment = current_user.payments.build(payment_params)
    begin
      ActiveRecord::Base.transaction do
        if @fee.amount - @fee.total_paid == @payment.amount
          @fee.is_done = true
        end
        @fee.total_paid = @fee.total_paid + @payment.amount
        raise ActiveRecord::Rollback if !@fee.save
        raise ActiveRecord::Rollback if !@payment.save
      end
      respond_to do |format|
        format.json { render json: { error_code: '0' } }
      end
    rescue Exception => e
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

  def payment_params
    params.permit(:name, :pay_mode, :pay_account, :get_mode, :get_account, :amount, :fee_id, :student_id, :done_at)
  end
end
