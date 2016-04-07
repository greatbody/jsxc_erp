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

  task :student_status => :environment do
    p "开始更新数据..."
    Student.where.not(signed_at: nil).where.not(km1_status: nil).each do |student|
      p "处理 #{student.name} .."
      exam_record = student.exam_records.build(kemu: 1)
      case student.km1_status
      when "can_order"
        p "can_order"
        exam_record.update(can_book: true, status: :wait)
      when "ordered"
        p "ordered"
        exam_record.update(can_book: true, need_book: true, status: :booked)
      when "passed"
        p "passed"
        exam_record.update(can_book: true, need_book: true, status: :passed)
      when "failed"
        p "failed"
        exam_record.update(can_book: true, need_book: true, status: :passed)
      when "need_order"
        p "need_order"
        exam_record.update(need_book: true, status: :wait)
      end
      exam_record.save
    end
    p "已完成，所有数据已处理"
    # Book.where('title LIKE ?', '%Rails%').update_all(author: 'David')
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
