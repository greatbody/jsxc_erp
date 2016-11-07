class PayUnitsController < ApplicationController
  def index
  end

  def payments
    @pay_unit_id = params[:pay_unit_id]
    if @pay_unit_id.to_i == -1
      @payments = Payment.where("get_unit_id is null or pay_unit_id is null").order(done_at: :desc)
      @total_paid = 0
      @total_get = 0
    else
      pay_unit = PayUnit.find(params[:pay_unit_id])
      @payments = pay_unit.all_payments.order(done_at: :desc)
      @total_paid = pay_unit.pay_record.sum(:amount)
      @total_get = pay_unit.get_record.sum(:amount)
    end
    render :partial => 'payments'
  end
end
