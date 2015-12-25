class NotifyStudentJob < ActiveJob::Base
  queue_as :default
  include SendSms
  def perform(student_id, job_id)
    student = Student.find(student_id)
    notify_time = Time.now
    case job_id
    when 'notify_got_number'
      unless student.nil? || student.phone.blank?
        res_card = student.residence_cards.last
        coach = student.coach
        residence_num(student, res_card, coach) if res_card.present? && coach.present? && res_card.card_id.present? && coach.phone.present?
        # 更新通知时间
        res_card.update(notify_at: notify_time) if res_card.notify_at.nil?
        res_card.update(last_notify_at: notify_time)
      end
    when 'notify_got_card'
      unless student.nil?
        residence_card(student)
        res_card.update(fatch_notify_at: notify_time) if res_card.fatch_notify_at.nil?
        res_card.update(last_fatch_notify_at: notify_time)
      end
    end
  end
end
