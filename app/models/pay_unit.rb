class PayUnit < ActiveRecord::Base
  enum unit_type: [:t_student, :t_coach, :t_staff, :t_company, :t_gov]

  belongs_to :student
  has_many :pay_accounts
  # has_many :payments, ->(pay_unit) { unscope(where: :pay_unit_id).where("get_unit_id = ? OR pay_unit_id = ?", pay_unit.id, pay_unit.id) }, class_name: 'Payment'
  has_many :pay_record, class_name: 'Payment', foreign_key: 'pay_unit_id'
  has_many :get_record, class_name: 'Payment', foreign_key: 'get_unit_id'

  def self.units_for_select
    units = [['', '']]
    PayUnit.all.each do |payunit|
      units << ["#{payunit.name} (#{payunit.phone})", payunit.id]
    end
    units
  end

  def all_payments
    Payment.where("pay_unit_id = :id OR get_unit_id = :id", id: id)
  end
end
