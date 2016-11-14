class PayUnitsController < ApplicationController
  def index
  end

  def payments
    @pay_unit_id = params[:pay_unit_id]
    if @pay_unit_id.to_i == -1
      @payments = Payment.unclassified.order(done_at: :desc)
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

  def pay_accounts_select
    @pay_accounts = PayUnit.find(params[:id]).pay_accounts
    render partial: 'pay_accounts_select'
  end

  def get_accounts_select
    @pay_accounts = PayUnit.find(params[:id]).pay_accounts
    render partial: 'get_accounts_select'
  end
end
