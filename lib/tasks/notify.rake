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
end
