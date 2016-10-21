class Payment < ActiveRecord::Base
  enum pay_mode: [:p_alipay, :p_bank, :p_cash]
  enum get_mode: [:g_alipay, :g_bank, :g_cash]

  belongs_to :user
  belongs_to :student
  belongs_to :fee

  def self.pay_modes_for_select
    pay_modes.map do |pay_mode, _|
      [I18n.t("payment.pay_mode.#{pay_mode}"), pay_mode]
    end
  end

  def self.get_modes_for_select
    get_modes.map do |get_mode, _|
      [I18n.t("payment.get_mode.#{get_mode}"), get_mode]
    end
  end
end
