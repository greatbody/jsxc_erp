class NotifySmsConsultantJob < ActiveJob::Base
  queue_as :default
  include SendSms
  def perform(student_id)
    student = Student.find(student_id)
    user = student.user

    unless student.nil? || student.phone.blank? || user.nil?
      assign_consultant(student, user)
    end
  end
end
