module SendNotifications
  def send_task_notify(notify)
    uri = 'https://jianliao.com/v2/services/webhook/e54974eb26dffe4a3cf09a574ac56a2c42578929'
    json_data = {
      title: "任务通知",
      text: <<-EOS
      发布人：#{notify[:sender][:name]}（手机：#{notify[:sender][:phone]}）
      发布时间：#{Time.now.to_s(:db)}
      消息：
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#{notify[:processor]}你好，请于#{notify[:task_date]}处理#{notify[:student][:name]}学员（手机：#{notify[:student][:phone]}）的#{notify[:task_type]}。
      EOS
    }.to_json
    response = RestClient.post uri, json_data, content_type: :json, accept: :json
  end

  def send_html(html)
    uri = 'https://jianliao.com/v2/services/webhook/e124d435e2e78297bd8a2fb152346137c0361fad'
    json_data = {
      title: "微信消息",
      text: "#{html}"
    }.to_json
    response = RestClient.post uri, json_data, content_type: :json, accept: :json
  end

  def send_erp_notify(notify)
    uri = 'https://jianliao.com/v2/services/webhook/ec09bfa1640e70c3a43ca920350981aad33b537a'
    json_data = {
      title: "ERP操作通知",
      text: <<-EOS
      操作人：#{notify[:operator]}<br>
      操作时间：#{Time.now.localtime.to_s(:db)}<br>
      消息：#{notify[:message]}
      EOS
    }.to_json
    response = RestClient.post uri, json_data, content_type: :json, accept: :json
  end
end
