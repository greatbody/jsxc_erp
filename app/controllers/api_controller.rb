class ApiController < ApplicationController
  protect_from_forgery with: :null_session

  def notify
    api_key = Rails.configuration.x.jisuxuechekey
    api_timestamp = params[:timestamp].to_s
    api_signature = params[:signature].to_s
    api_action = params[:action].to_s
    str = "timestamp=#{api_timestamp}&key=#{api_key}&action=#{api_action}"
    signature = Digest::SHA1.hexdigest(str)
    if signature == api_signature
      render html: 'success'
    else
      render html: ''
    end
  end

end
