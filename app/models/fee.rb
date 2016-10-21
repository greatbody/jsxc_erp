class Fee < ActiveRecord::Base
  enum fee_type: [:baoming, :tijian, :kaoshi, :qita]
  enum fee_mode: [:shouru, :zhichu]

  belongs_to :student
  has_many :payments

  def fee_type_name
    if fee_type.nil?
      ''
    else
      I18n.t("fee.fee_type.#{fee_type}")
    end
  end

  def fee_mode_name
    if fee_mode.nil?
      ''
    else
      I18n.t("fee.fee_mode.#{fee_mode}")
    end
  end

  def self.fee_types_for_select
    fee_types.map do |fee_type, _|
      [I18n.t("fee.fee_type.#{fee_type}"), fee_type]
    end
  end

  def self.fee_modes_for_select
    fee_modes.map do |fee_mode, _|
      [I18n.t("fee.fee_mode.#{fee_mode}"), fee_mode]
    end
  end
end
