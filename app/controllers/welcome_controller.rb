# encoding: UTF-8
class WelcomeController < ApplicationController
  require 'phone_ext'
  before_action :authenticate_user!, only: [:index]
  def index
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
  end

  def demo
  end
end
