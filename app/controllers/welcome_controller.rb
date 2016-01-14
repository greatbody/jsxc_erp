# encoding: UTF-8
class WelcomeController < ApplicationController
  require 'phone_ext'
  before_action :authenticate_user!, only: [:index]
  def index
    start = Date.today.ago(1.month).to_date
    finish = Date.today
    @dates = []
    @datas = []
    @data_sum = []
    signed_count_total = 0
    while(start < finish) do
      start += 1.day
      signed_count = Student.where(signed_at: start).count
      signed_count_total += signed_count
      @dates << start.strftime("%m-%d")
      @datas << signed_count
      @data_sum << signed_count_total
    end
  end

  def demo
  end
end
