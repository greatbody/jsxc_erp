# encoding: UTF-8
module Authorize
  def self.verify?(params)
    params = params.dup
    sign = params.delete('signature') || params.delete(:signature)
    self.sign_data(params) == sign
  end

  def self.get_authorized_json(content)
    data = {
      key: Rails.configuration.x.jisuxuechekey,
      timestamp: Time.now.to_i,
      content: content
    }
    signature = self.sign_data(data)
    data = data.merge({ signature: signature })
    data.to_json
  end

  def self.sign_data(params)
    key = params.delete(:key)
    query = params.sort.map do |key, value|
      "#{key}=#{value}"
    end.join('&')
    Digest::MD5.hexdigest("#{query}&key=#{key || Rails.configuration.x.jisuxuechekey}").upcase
  end

end
