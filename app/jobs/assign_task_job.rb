class AssignTaskJob < ActiveJob::Base
  queue_as :default
  # include SendSms
  include SendNotifications
  def perform(student_id, processor_id, sender_id, business_type, task_date)
    UserMailer.assign_task(student_id, processor_id, sender_id, business_type, task_date).deliver_now
  end
end
