class PayAccount < ActiveRecord::Base
  enum account_type: [:t_net, :t_bank, :t_cash]

  belongs_to :student
  belongs_to :pay_unit

  has_many :pay_record, class_name: 'Payment', foreign_key: 'pay_account_id'
  has_many :get_record, class_name: 'Payment', foreign_key: 'get_account_id'
end
