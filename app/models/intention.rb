class Intention < ActiveRecord::Base
  belongs_to :student
  belongs_to :user

  def next_contact_date
    last_contact = ContactLog.where(student_id: student.id).order(created_at: :desc).first
    if last_contact.attribute_present?(:next_contact_at) then
      last_contact.next_contact_at.to_date
    else
      nil
    end
  end
end
