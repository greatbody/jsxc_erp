# encoding: UTF-8
class Intention < ActiveRecord::Base
  enum current_status: [:wait_call, :contacting, :booking, :wait_pay, :signed_up, :canceled]

  belongs_to :student
  belongs_to :user

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
    contact_logs = student.contact_logs.where(current_status: current_status)
    if contact_logs.count > 0
      contact_logs.order(created_at: :desc).first.created_at.to_s(:db)
    else
      '未知'
    end
  end

end
