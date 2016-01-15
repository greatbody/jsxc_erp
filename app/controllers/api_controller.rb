class ApiController < ApplicationController
  require 'authorize'
  include SendNotifications
  protect_from_forgery with: :null_session

  def notify
    if Authorize.verify?(params[:api])
      render html: 'success'
      send_html('success')
    else
      render html: 'error'
      send_html('error')
    end
  end

end
