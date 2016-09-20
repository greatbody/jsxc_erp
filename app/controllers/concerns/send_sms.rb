module SendSms
  def send_token_sms(phone, token)
    send_sms(phone, '8106', token)
  end
  # 提醒学员来拿卡
  def residence_card(student)
    # 领取居住证通知模板
    # {1}同学，您的居住证卡片已经制作完成，请于周一至周六或其它法定上班时间到我公司领取证件，公司地址：武汉市洪山区珞狮路147号武汉理工大学生创业园404（以及407）室，联系电话：027-51112676。祝您学车顺利。
    send_sms(student.phone, '18801', [student.name])
  end
  # 告知教练、学员号码出来
  def residence_num(student, res_card, coach)
    # 学员模板
    # {1}同学，您的居住证编号：{2}，地址：{3}。若教练3日内未联系您，请联系教练{4}，祝学习工作顺利。
    send_sms(student.phone, '18290', [res_card.name, res_card.card_id, res_card.current_address, coach.name])
    # 教练模板
    # {1}教练，学员{2}的居住证号：{3}，地址：{4}，请尽快处理档案，祝工作顺利。
    send_sms(coach.phone, '18289', [coach.name, res_card.name, res_card.card_id, res_card.current_address])
  end
  # 指派任务
  def assign_task(processer, sender, student, business_type)
    # {1}你好，请处理{2}学员（手机：{3}）的{4}。指派人：{5}（手机：{6}）
    send_sms(processer.phone, '18826', [processer.name, student.name, student.phone, business_type, sender.name, sender.phone])
  end
  # 指派学车顾问的消息
  def assign_consultant(student, user)
    # 感谢您选择极速学车，我们为您安排了专属的学车顾问{1}(手机：{2})，学车过程中如有任何的疑问、遇到任何的困难都可以与他（她）联系，祝您学车顺利，极速拿证！
    content = user.phone + ' 微信：' + user.weixin
    send_sms(student.phone, '20701', [user.name, content])
  end

  def send_adver_sms(student)
    #发送短信给已毕业学员
    send_sms(student.phone, '28616', [student.name])
  end

  def send_adver_unget(student)
    #发送短信给尚未毕业的学员
    send_sms(student.phone, '28625', [student.name])
  end

  def send_activateceo_sms(source)
    #发送短信给校园CEO
    send_sms(source.phone, '28640', [source.name])
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
