namespace :process do
  task :coach => :environment do
    include ApiService
    Coach.where(is_locked: false).each do |coach|
      p "processing coach #{coach.id}"
      # update age
      coach.process_coach
    end
    p "done"
  end
  # 调用实例
  # bundle exec rake fix:add_role role_name='trys'
  # task :add_role => :environment do |t, args|
  #   role_name = ENV['role_name']
  #   Role.create(name: role_name)
  #   p "#{role_name} 添加完成"
  # end

  # task :update_student_birthday => :environment do |t, args|
  #   Student.where("LENGTH(id_card) = 18 and birthday is null").each do |student|
  #     birthday = student.id_card[6..13]
  #     student.update(birthday: birthday)
  #     p "#{student.name} 的生日应该是 #{birthday}"
  #   end
  # end
end
