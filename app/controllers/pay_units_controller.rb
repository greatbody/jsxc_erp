class PayUnitsController < ApplicationController
  def index
  end

  def payments
    @pay_unit_id = params[:pay_unit_id]
    @pay_unit = PayUnit.find(params[:pay_unit_id])
    @payments = @pay_unit.all_payments.order(done_at: :desc)
    @total_paid = @pay_unit.pay_record.sum(:amount)
    @total_get = @pay_unit.get_record.sum(:amount)
    render :partial => 'payments'
  end
end
