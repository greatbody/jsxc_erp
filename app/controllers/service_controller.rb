# encoding: UTF-8
class ServiceController < ApplicationController
  include SendNotifications
  before_action :authenticate_user!
  authorize_resource :class => false
  def assign_task
    student_id = params[:student_id]
    processor_id = params[:processor_id]
    sender_id = current_user.id
    task_type = params[:task_type]
    task_date = params[:task_date]
    if student_id.blank? || processor_id.blank?
      render json: { msg_code: 'error', msg_text: '未指定学员或处理人' }
    else
      AssignTaskJob.perform_later(student_id, processor_id, sender_id, task_type, task_date)
      render json: { msg_code: 'success', msg_text: '' }
    end
  end

  def search
    q = params[:q].to_s
    items = []

    if can? :read, Student
      students = Student.where('phone LIKE :q OR name LIKE :q', { q: "%#{q}%" })
      students.each do |student|
        items << {
          business: '学员',
          name: "#{student.name}",
          html_url: "/students/#{student.id}",
          description: ''
        }
      end
    end

    if can? :read, ResidenceCard
      residence_cards = ResidenceCard.where('card_id LIKE :q OR name LIKE :q OR gender LIKE :q OR ethnicity LIKE :q OR id_card LIKE :q OR home_region LIKE :q OR current_address LIKE :q', { q: "%#{q}%" })
      residence_cards.each do |residence_card|
        items << {
          business: '居住证记录',
          name: "#{residence_card.name} | #{I18n.t("residence_card.current_status.#{residence_card.current_status}")}",
          description: "身份证：#{residence_card.id_card}"
        }
      end
    end

    if can? :read, Coach
      coaches = Coach.where('phone LIKE :q OR name LIKE :q OR id_card LIKE :q OR wechat LIKE :q OR qq LIKE :q OR coaching_license LIKE :q OR driving_license LIKE :q', { q: "%#{q}%" })
      coaches.each do |coach|
        items << {
          business: '教练',
          name: "#{coach.name}",
          description: ''
        }
      end
    end

    if can? :read, Intention
      intentions = Intention.where("source LIKE ?", "%#{q}%")
      intentions.each do |intention|
        items << {
          business: '意向',
          name: "#{intention.student.name}",
          html_url: "/intentions/#{intention.id}",
          description: ''
        }
      end
    end

    if can? :read, ContactLog
      contact_logs = ContactLog.where('contact_log LIKE ?', "%#{q}%")
      contact_logs.each do |contact_log|
        items << {
          business: '联系记录',
          name: "#{contact_log.student.name} | #{contact_log.created_at.to_date.to_s(:db)}",
          description: "#{contact_log.contact_log}"
        }
      end
    end

    if can? :read, User
      users = User.where('phone LIKE :q OR name LIKE :q OR email LIKE :q', { q: "%#{q}%" })
      users.each do |user|
        items << {
          business: '管理员',
          name: "#{user.name} | #{user.phone}",
          description: "上次登陆： #{user.last_sign_in_at.to_s(:db) if user.last_sign_in_at.present?}"
        }
      end
    end

    render json: { items: items }
  end

  def daily_sign
    current_user.daily_signs.build.save
    notify = {
      operator: current_user.name,
      message: "完成了#{Date.today.to_s(:db)}的签到"
    }
    send_erp_notify(notify)
    render html: ''
  end

  def sms_consultant
    student_id = params[:student_id]
    NotifySmsConsultantJob.perform_later(student_id)
    render json: { msg_code: 'success', msg_text: '' }
  end
end
