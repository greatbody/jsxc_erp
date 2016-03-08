# encoding: UTF-8
class PcApplicationController < ApplicationController
  before_action :check_browser, :check_user
  include BrowserExt

  private

  def check_browser
    redirect_to m_root_path if is_phone(browser)
  end

  def check_user
    redirect_to m_root_path if current_user.present? && current_user.has_role?(:school_ceo)
  end
end
