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

  task :filter => :environment do
    ['张元元', '刘思昊', '李钢', '刘珍', '邓雅倩', '叶文朝', '何秀', '胡豹', '陈凯席', '卢华南',
     '张德叶', '孔小莉', '夏彩芸', '胡晖', '雷淑芬', '喻晨星', '杨颖姗', '李婷婷', '白玉清',
     '雷小云', '彭婷', '张雪雷', '唐帅', '杨强', '李豪', '李青', '邹小珍', '呙亚慧', '李德全',
     '梅云河', '陈后全', '何文奇', '何文奇', '邹强', '梁清芸', '温作超', '胡凯', '胡凯', '黎寒',
     '黎寒', '王丹丹', '窦锦鹏', '王锦', '王萍', '窦雪茹', '谢巧均', '郑莹莹', '杨建新',
     '徐加泉', '涂明', '佘海亮', '邓少芳', '徐冬', '刘丰', '廖思宇', '王梦巧', '潘俞同', '梁亚文',
     '陈明', '唐甜', '梅艳雪', '孙然', '郭传宇', '吕松伟', '唐玉滕', '金妙', '李聿珩', '李思奥',
     '穆远亚', '李永强', '钟东昌', '苏瑞', '朱佳晖', '张帅', '张睛', '陈俊明', '关沛文', '何群',
     '代都', '黄勤格', '詹凯文', '周瑛达', '梅枭央', '张屹哲', '宋淑利', '许志聪', '吴金风', '刘雨',
     '王超', '母坤', '黄迪', '曹驰', '陈晗', '柯奇云', '李鑫', '苏恒', '彭光学', '柯毕成', '李鹏',
     '邬乔桥', '唐杰', '崔岳飞', '陈彩薇', '张雄威', '刘侃', '胡进', '龚振', '籍晓岚', '刘超群',
     '亓科云', '刘悦', '陈孜学', '史梦杰', '戴俊明', '苏杰', '焦哲', '徐彪', '刘文豪', '蔡思倩',
     '张晓青', '朱诗雨', '李松蔓', '王聚幸', '倪伟', '陈克雄', '肖伟翔', '潘鹏', '张天龙', '王中辉',
     '张朋', '夏冬', '陶鑫', '邓辉', '江婷', '赵珍慧', '胡雄锋', '徐家展', '顾珺', '董勇涛', '许德州',
     '谢旨涵', '张鹏程', '孙常宝', '杨雅文', '李鑫波', '唐世全', '钮振嘉', '程慧', '罗成', '胡宏炜',
     '邱浩杰', '高一铖', '邹梦琦', '陈必成', '刘武标', '繆磊', '火登翔', '李玉炎', '王成刚', '程娟',
     '干震', '陈皓跃', '朱朋辉', '钟宇轩', '童剑', '王希璞', '胡蔓清', '朱鹏超', '谌先博', '洪浩', '江哲',
     '黄量', '李浩', '祝业盼', '陈坤良', '吴俊奇', '朱满意', '佃航', '谭浄', '姜遥歌', '唐明', '毛一丰',
     '万海鹏', '王科', '沈礼思', '刘荣', '孔威', '骆敏', '申黄倩', '李宁'].each do |stu_name|
      if Student.where(name: stu_name).count == 0
        puts "#{stu_name} 不在系统中"
      end
    end
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
