# encoding: UTF-8
class WelcomeController < ApplicationController
  require 'phone_ext'
  before_action :authenticate_user!, only: [:index]
  def index
  # prepare data for carve display
    start = Date.today.ago(2.month).to_date
    finish = Date.today
    @dates = []
    @signed_up_datas = []
    @signed_up_data_sum = []
    @student_contact_logs = []
    signed_count_total = 0
    while(start < finish) do
      start += 1.day
      # 当前报名人数
      signed_count = Student.where(signed_at: start).count
      # 累计报名人数
      signed_count_total += signed_count
      # 插入时间轴数据
      @dates << start.strftime("%m-%d")
      # 插入每天报名数据
      @signed_up_datas << signed_count
      # 插入累计到每天的报名数据
      @signed_up_data_sum << signed_count_total
      # 插入每天的联系记录数据
      @student_contact_logs << ContactLog.where("date(created_at) = ?", start).count
    end
  # for message display
    @messages = colleact_messages
  end

  def demo
  end

  def map
    @train_fields = TrainField.all
    @schools = School.where("longitude is not null and latitude is not null")
    @average_longitude = TrainField.average(:longitude).to_f
    @average_latitude = TrainField.average(:latitude).to_f
  end

  private

  def colleact_messages
    messages = []
    messages += birthday_messages
  end

  def birthday_messages
    messages = []
    Student.where("birthday is not null and signed_at is not null").each do |student|
      days_before_birthday = student.birthday.days_before_birthday
      messages << "<a target='_blank' href='/students/#{student.id}'>#{student.name}</a> #{days_before_birthday} 天后过生日" if days_before_birthday < 10
    end
    messages
  end

end
