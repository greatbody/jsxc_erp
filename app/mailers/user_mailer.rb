class UserMailer < ApplicationMailer
  default from: 'dev@jisuxueche.com'

  def assign_task(student_id, processor_id, sender_id, business_type, task_date)
    @student = Student.find(student_id)
    @processor = User.find(processor_id)
    @sender = User.find(sender_id)
    @business_type = business_type
    @task_date = task_date
    mail(to: @processor.email, subject: "#{Time.now.strftime('%Y%m%d%H%M%S')}你有新的任务了") if @processor.email.present?
  end
end
