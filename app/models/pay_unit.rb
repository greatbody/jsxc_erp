class PayUnit < ActiveRecord::Base
  enum unit_type: [:t_student, :t_coach, :t_staff, :t_company, :t_gov]

  belongs_to :student
  has_many :pay_accounts

  def self.units_for_select
    units = [['', '']]
    PayUnit.all.each do |payunit|
      units << ["#{payunit.name} (#{payunit.phone})", payunit.id]
    end
    units
  end
end
