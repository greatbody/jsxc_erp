# encoding: UTF-8
class Intention < ActiveRecord::Base
  enum current_status: { wait_call: 0, contacting: 1, booking: 2, wait_pay: 3, signed_up: 4, canceled: 5 }

  belongs_to :student
  belongs_to :user
  belongs_to :student_source

  validates :source, length: { maximum: 255, message: '来源名称超出长度限制' }

  def self.current_status_for_select
    current_statuses.map do |current_status, _|
      [I18n.t("current_status.#{current_status}"), current_status]
    end
  end

  def current_status_text
    I18n.t("current_status.#{current_status}")
  end

  def current_status_date
    contact_logs = student.contact_logs.where(current_status: self[:current_status])
    if contact_logs.count > 0
      contact_logs.order(created_at: :desc).first.created_at.to_date.to_s(:db)
    else
      '未知'
    end
  end

end
