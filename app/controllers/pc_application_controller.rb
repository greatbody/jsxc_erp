# encoding: UTF-8
class PcApplicationController < ApplicationController
  before_action :check_browser
  include BrowserExt

  private

  def check_browser
    redirect_to m_root_path if is_phone(browser)
  end
end
