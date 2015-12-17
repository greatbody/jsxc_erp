module SendSms
  def send_token_sms(phone, token)
    send_sms(phone, '8106', token)
  end
  # 
  def residence_card_number(student_phone, coach_name, coach_phone)
    # send_sms(student_phone, '11994', [coach_name, coach_phone])
  end

  def residence_card_done(student_phone, coach_name, coach_phone)
    # send_sms(student_phone, '9356', [coach_name, coach_phone])
  end

  def send_jisuhui_purchase(jisuhui)
    send_sms(jisuhui.phone, 'phone', [jisuhui.name, jisuhui.trade_code])
  end

  protected

  def send_sms(phone, template_id, *params)
    soft_version = '2014-06-30'
    account_sid = '61582df63b430cb259c8fc0ef6a258a6'
    auth_token = '786579c42b58e18cd66661a4b32b2df0'
    app_id = '2ec74161d39247de97f0864ab4713fe9'
    time = Time.now.strftime('%Y%m%d%H%M%S')
    sign = Digest::MD5.hexdigest(account_sid + auth_token + time).upcase
    authorization = Base64.strict_encode64(account_sid + ':' + time)

    uri = "https://api.ucpaas.com/#{soft_version}/Accounts/#{account_sid}/Messages/templateSMS?sig=#{sign}"
    json_data = {
      templateSMS: {
        appId: app_id,
        param: params.join(','),
        templateId: template_id,
        to: phone
      }
    }.to_json
    response = RestClient.post uri, json_data, content_type: :json, accept: :json, authorization: authorization
  end
end
