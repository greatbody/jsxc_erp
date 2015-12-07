class ContactLog < ActiveRecord::Base
  belongs_to :student
  belongs_to :user

  enum contact_type: [:intent, :trylearn, :sign_up, :suggestion, :complaint]
  enum current_status: [:wait_call, :in_contact, :booked_try, :wait_pay, :signed_up]

  def self.contact_types_for_select
    contact_types.map do |contact_type, _|
      [I18n.t("contact_types.#{contact_type}"), contact_type]
    end
  end

end
