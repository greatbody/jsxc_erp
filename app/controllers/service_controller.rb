# encoding: UTF-8
class ServiceController < ApplicationController
  before_action :authenticate_user!
  def assign_task
    student_id = params[:student_id]
    processor_id = params[:processor_id]
    sender_id = current_user.id
    task_type = params[:task_type]
    if student_id.blank? || processor_id.blank?
      render json: { msg_code: 'error', msg_text: '未指定学员或处理人' }
    else
      AssignTaskJob.perform_later(student_id, processor_id, sender_id, task_type)
      render json: { msg_code: 'success', msg_text: '' }
    end
  end

  def search
    q = params[:q].to_s
    items = []

    intentions = Intention.where("source LIKE ?", "%#{q}%")
    students = Student.where('phone LIKE :q OR name LIKE :q', { q: "%#{q}%" })
    coaches = Coach.where('phone LIKE :q OR name LIKE :q OR id_card LIKE :q OR wechat LIKE :q OR qq LIKE :q OR coaching_license LIKE :q OR driving_license LIKE :q', { q: "%#{q}%" })
    contact_logs = ContactLog.where('contact_log LIKE ?', "%#{q}%")
    residence_cards = ResidenceCard.where('card_id LIKE :q OR name LIKE :q OR gender LIKE :q OR ethnicity LIKE :q OR id_card LIKE :q OR home_region LIKE :q OR current_address LIKE :q', { q: "%#{q}%" })
    users = User.where('phone LIKE :q OR name LIKE :q OR email LIKE :q', { q: "%#{q}%" })

    intentions.each do |intention|
      items << {
        business: '意向信息',
        name: "#{intention.student.name}",
        html_url: "/intentions/#{intention.id}",
        description: ''
      }
    end

    students.each do |student|
      items << {
        business: '学员信息',
        name: "#{student.name}",
        html_url: "/students/#{student.id}",
        description: ''
      }
    end

    coaches.each do |coach|
      items << {
        business: '教练',
        name: "#{coach.name}",
        description: ''
      }
    end

    contact_logs.each do |contact_log|
      items << {
        business: '联系记录',
        name: "#{contact_log.student.name} | #{contact_log.created_at.to_date.to_s(:db)}",
        description: "#{contact_log.contact_log}"
      }
    end

    residence_cards.each do |residence_card|
      items << {
        business: '居住证记录',
        name: "#{residence_card.name} | #{I18n.t("residence_card.current_status.#{residence_card.current_status}")}",
        description: "身份证：#{residence_card.id_card}"
      }
    end

    users.each do |user|
      items << {
        business: '管理员',
        name: "#{user.name} | #{user.phone}",
        description: "上次登陆： #{user.last_sign_in_at.to_s(:db)}"
      }
    end

    render json: { items: items }
  end
end