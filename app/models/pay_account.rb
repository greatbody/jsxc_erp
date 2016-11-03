class PayAccount < ActiveRecord::Base
  enum account_type: [:t_net, :t_bank, :t_cash]

  belongs_to :student
  belongs_to :pay_unit
end
