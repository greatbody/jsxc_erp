class AssignTaskJob < ActiveJob::Base
  queue_as :default
  # include SendSms
  include SendNotifications
  def perform(student_id, processor_id, sender_id, business_type, task_date)
    student = Student.find(student_id)
    processor = User.find(processor_id)
    sender = User.find(sender_id)
    # assign_task(processor, sender, student, business_type)
    notify = {
      sender: { name: sender.name, phone: sender.phone },
      processor: processor.name,
      student: { name: student.name, phone: student.phone },
      task_type: business_type,
      task_date: task_date
    }
    send_task_notify(notify)
  end
end
