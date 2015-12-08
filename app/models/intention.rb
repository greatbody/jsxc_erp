class Intention < ActiveRecord::Base
  belongs_to :student
  belongs_to :user

  enum current_status: [:wait_call, :contacting, :booking, :wait_pay, :signed_up]

  def next_contact_date
    last_contact = ContactLog.where(student_id: student.id).order(created_at: :desc).first
    return nil if last_contact.nil?
    if last_contact.attribute_present?(:next_contact_at) then
      last_contact.next_contact_at.to_date
    else
      nil
    end
  end
end
