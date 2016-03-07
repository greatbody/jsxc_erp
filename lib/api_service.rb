module ApiService
  def test_send(content)
    uri = Rails.configuration.x.jisuxueche_port
    response = RestClient.post uri, get_authorized_json(content), content_type: :json, accept: :json
    response.to_s
  end

  private

  def get_authorized_json(content)
    data = {
      key: Rails.configuration.x.jisuxuechekey,
      timestamp: Time.now.to_i,
      content: content
    }
    signature = sign_data(data)
    data = data.merge({ signature: signature })
    data.to_json
  end

  def sign_data(params)
    key = params.delete(:key)
    query = params.sort.map do |key, value|
      "#{key}=#{value}"
    end.join('&')
    Digest::MD5.hexdigest("#{query}&key=#{key || Rails.configuration.x.jisuxuechekey}").upcase
  end
end
