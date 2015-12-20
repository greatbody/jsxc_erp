# encoding: UTF-8
class ResidenceCard < ActiveRecord::Base
  enum current_status: [:id_card_received, :id_card_returned, :have_number, :notify_sent, :have_card, :return_card]
  enum process_by: [:jsxc, :student, :coach]

  belongs_to :student

  def self.process_by_for_select
    process_bies.map do |process_by, _|
      [I18n.t("residence_card.process_by.#{process_by}"), process_by]
    end
  end
end
