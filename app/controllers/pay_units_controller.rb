class PayUnitsController < ApplicationController
  def index
  end

  def payments
    @pay_unit_id = params[:pay_unit_id]
    @payments = PayUnit.find(params[:pay_unit_id]).all_payments.order(done_at: :desc)
    render :partial => 'payments'
  end
end
