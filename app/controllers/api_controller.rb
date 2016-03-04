class ApiController < ApplicationController
  # accept request
  require 'authorize'
  include SendNotifications
  protect_from_forgery with: :null_session

  def notify
    if Authorize.verify?(params[:api])
      action_params = params[:api][:content]
      send_html(action_params.to_json)
      render html: action_params.to_json
    else
      render html: 'error'
    end
  end
end
