namespace :sync do
  require 'api_service'
  task :coach => :environment do
    include ApiService
    Coach.where(is_locked: false).each do |coach|
      p "processing coach #{coach.id}"
      data = {
        job: 'sync_coach',
        data: {
          phone: coach.phone,
          name: coach.name,
          id_card: coach.id_card,
          gender: coach.gender
        }
      }
      # update age
      if coach.id_card.length == 18
        data[:data][:age] = Date.today.year.to_i - coach.id_card[6..9].to_i
      end
      p test_send(data.to_json)
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
