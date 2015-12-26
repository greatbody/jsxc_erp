class AssignTaskJob < ActiveJob::Base
  queue_as :default
  include SendSms
  def perform(student_id, processer_id, sender_id, business_type)
    student = Student.find(student_id)
    processer = User.find(processer_id)
    sender = User.find(sender_id)
    # assign_task(processer, sender, student, business_type)
  end
end
