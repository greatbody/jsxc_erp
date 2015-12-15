# encoding: UTF-8
class ContactLog < ActiveRecord::Base
  belongs_to :student
  belongs_to :user

  enum contact_type: [:intent, :trylearn, :sign_up, :suggestion, :complaint]
  enum current_status: [:wait_call, :contacting, :booking, :wait_pay, :signed_up]

  def self.contact_types_for_select
    contact_types.map do |contact_type, _|
      [I18n.t("contact_types.#{contact_type}"), contact_type]
    end
  end

  def self.current_status_for_select
    current_statuses.map do |current_status, _|
      [I18n.t("current_status.#{current_status}"), current_status]
    end
  end

end
