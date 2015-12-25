class NotifyStudentJob < ActiveJob::Base
  queue_as :default
  include SendSms
  def perform(student_id, job_id)
    student = Student.find(student_id)
    case job_id
    when 'notify_got_number'
      unless student.nil? || student.phone.blank?
        res_card = student.residence_cards.last
        coach = student.coach
        residence_num(student, res_card, coach) if res_card.present? && coach.present? && res_card.card_id.present? && coach.phone.present?
      end
    when 'notify_got_card'
      residence_card(student) if student.present?
    end
  end
end
