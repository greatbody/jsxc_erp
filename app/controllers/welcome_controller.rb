# encoding: UTF-8
class WelcomeController < ApplicationController
  require 'phone_ext'
  before_action :authenticate_user!, only: [:index]
  def index
    start = Date.today.ago(1.month).to_date
    finish = Date.today
    @dates = []
    @datas = []
    while(start < finish) do
      start += 1.day
      @dates << start.strftime("%m-%d")
      @datas << Student.where(signed_at: start).count
    end
  end

  def demo
  end
end
