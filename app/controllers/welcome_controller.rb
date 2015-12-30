# encoding: UTF-8
class WelcomeController < ApplicationController
  require 'phone_ext'
  before_action :authenticate_user!, only: [:index]
  def index
  end

  def demo
  end
end
