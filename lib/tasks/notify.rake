namespace :notify do
  task :assign_task => :environment do
    include SendNotifications
    notify = {
      sender: { name: '孙瑞', phone: '1877102427' },
      processor: '胡成',
      student: { name: '柯奇云', phone: '13349928561' },
      task_type: '办理居住证'
    }
    send_task_notify(notify)
    p "done"
  end

  task :send_advertise => :environment do
    include SendSms
    Student.where(process: 5).each do |student|
      p "发送短信给#{student.name}"
      send_adver_sms(student)
      p "发送完成"
    end
  end

  task :send_advertise_unget => :environment do
    include SendSms
    Student.where(process: 0).each do |student|
      student.name = '' if student.name == student.phone
      p "发送短信给#{student.name}"
      send_adver_unget(student) if student.phone.present?
      p "发送完成"
    end
  end

  task :send_activate_ceos => :environment do
    include SendSms
    StudentSource.all.each do |source|
      source.name = '' if source.name == source.phone
      p "发送短信给#{source.name}"
      send_activateceo_sms(source) if source.phone.present?
      p "发送完成"
    end
  end

end
