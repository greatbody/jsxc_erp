namespace :fix do
  task :intention_next_contact => :environment do
    Intention.all.each do |intention|
      p "processing intention #{intention.id}"
      if intention.student.contact_logs.count > 0
        last_contact = intention.student.contact_logs.last
        intention.update(next_contact_at: last_contact.next_contact_at, current_status: last_contact.current_status)
      end
    end
    p "done"
  end
  # 调用实例
  # bundle exec rake fix:add_role role_name='trys'
  task :add_role => :environment do |t, args|
    role_name = ENV['role_name']
    Role.create(name: role_name)
    p "#{role_name} 添加完成"
  end

  task :update_student_birthday => :environment do |t, args|
    Student.where("LENGTH(id_card) = 18 and birthday is null").each do |student|
      birthday = student.id_card[6..13]
      student.update(birthday: birthday)
      p "#{student.name} 的生日应该是 #{birthday}"
    end
  end
end
