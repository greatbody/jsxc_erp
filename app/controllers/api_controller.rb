class ApiController < ApplicationController
  require 'authorize'
  include SendNotifications
  protect_from_forgery with: :null_session

  def notify
    if Authorize.verify?(params[:api])
      action_params = JSON.parse(params[:api][:content]).deep_symbolize_keys
      send_html(action_params.to_json)
      render html: action_params.to_json
    else
      render html: 'error'
    end
  end

  private

  def display_key(params)
    send_html(params[:b][:sex])
  end

end