class PayUnit < ActiveRecord::Base
  enum unit_type: [:t_student, :t_coach, :t_staff, :t_company, :t_gov]

  belongs_to :student
  has_many :pay_accounts
  has_many :payments, ->(pay_unit) { unscope(where: :pay_unit_id).where("get_unit_id = ? OR pay_unit_id = ?", pay_unit.id, pay_unit.id) }, class_name: 'Payment'

  def self.units_for_select
    units = [['', '']]
    PayUnit.all.each do |payunit|
      units << ["#{payunit.name} (#{payunit.phone})", payunit.id]
    end
    units
  end
end
