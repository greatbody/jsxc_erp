module SendSms
  def send_token_sms(phone, token)
    send_sms(phone, '8106', token)
  end
  # 提醒学员来拿卡
  def residence_card(student_phone, coach_name, coach_phone)
    # send_sms(student_phone, '11994', [coach_name, coach_phone])
  end
  # 告知教练、学员号码出来
  def residence_num(res_card, coach)
    # 学员模板
    # {1}同学，您的居住证编号：{2}，地址：{3}。若教练3日内未联系您，请联系教练{4}，祝学习工作顺利。
    send_sms(student.phone, '18290', [res_card.name, res_card.card_id, res_card.current_address, coach.name])
    # 教练模板
    # {1}教练，学员{2}的居住证号：{3}，地址：{4}，请尽快处理档案，祝工作顺利。
    send_sms(coach.phone, '18289', [coach.name, res_card.name, res_card.card_id, res_card.current_address])
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
