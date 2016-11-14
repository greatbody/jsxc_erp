class Payment < ActiveRecord::Base
  enum pay_mode: [:p_alipay, :p_bank, :p_cash]
  enum get_mode: [:g_alipay, :g_bank, :g_cash]

  belongs_to :user
  belongs_to :student
  belongs_to :fee
  belongs_to :pay_account, class_name: 'PayAccount'
  belongs_to :get_account, class_name: 'PayAccount'
  belongs_to :pay_unit, class_name: 'PayUnit'
  belongs_to :get_unit, class_name: 'PayUnit'

  scope :unclassified, -> { where( "get_unit_id is null or pay_unit_id is null or pay_account_id is null or get_account_id is null" ) }

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
