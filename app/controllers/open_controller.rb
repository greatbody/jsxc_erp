class OpenController < ApplicationController
  before_action :authenticate_user!, only: [:students, :coaches, :student_sources]
  def index
  end

  def map
    @train_fields = TrainField.all
    @schools = School.where("longitude is not null and latitude is not null")
    @average_longitude = TrainField.average(:longitude).to_f
    @average_latitude = TrainField.average(:latitude).to_f
  end

  def rank
    week_sql = <<-EOS
      SELECT `student_sources`.`id` AS id, `student_sources`.`name` AS name, count(`students`.`id`) AS count FROM `student_sources`
      LEFT OUTER JOIN `intentions` ON `intentions`.`student_source_id` = `student_sources`.`id`
      LEFT OUTER JOIN `students` ON `students`.`id` = `intentions`.`student_id` AND `students`.`signed_at` BETWEEN DATE_ADD(curdate(),INTERVAL -7 DAY) AND curdate()
      GROUP BY `student_sources`.`id`, `student_sources`.`name`
      ORDER BY count(`students`.`id`) DESC
    EOS

    month_sql = <<-EOS
      SELECT `student_sources`.`id` AS id, `student_sources`.`name` AS name, count(`students`.`id`) AS count FROM `student_sources`
      LEFT OUTER JOIN `intentions` ON `intentions`.`student_source_id` = `student_sources`.`id`
      LEFT OUTER JOIN `students` ON `students`.`id` = `intentions`.`student_id` AND `students`.`signed_at` BETWEEN DATE_ADD(curdate(),INTERVAL -30 DAY) AND curdate()
      GROUP BY `student_sources`.`id`, `student_sources`.`name`
      ORDER BY count(`students`.`id`) DESC
    EOS

    season_sql = <<-EOS
      SELECT `student_sources`.`id` AS id, `student_sources`.`name` AS name, count(`students`.`id`) AS count FROM `student_sources`
      LEFT OUTER JOIN `intentions` ON `intentions`.`student_source_id` = `student_sources`.`id`
      LEFT OUTER JOIN `students` ON `students`.`id` = `intentions`.`student_id` AND `students`.`signed_at` BETWEEN DATE_ADD(curdate(),INTERVAL -90 DAY) AND curdate()
      GROUP BY `student_sources`.`id`, `student_sources`.`name`
      ORDER BY count(`students`.`id`) DESC
    EOS
    @rank_week = StudentSource.connection.select_all(week_sql)
    @rank_month = StudentSource.connection.select_all(month_sql)
    @rank_season = StudentSource.connection.select_all(season_sql)

    render layout: 'work_tasks'
  end

  def students
    @students = Student.where.not(signed_at: nil)
  end

  def coaches
    @coaches = Coach.all
  end

  def student_sources
    @student_sources = StudentSource.all
  end

  def km1
    infos = []
    Student.where(process: 1).each do |student|
      unless student.id_card.blank? || student.name.blank?
        infos << student.name + ',' + student.id_card
      end
    end
    render plain: infos.join(';')
  end

  def asf82lasd00xal
    infos = []
    Student.where.not(signed_at: nil).each do |student|
      unless student.id_card.blank? || student.name.blank?
        infos << student.name + ',' + student.id_card
      end
    end
    render plain: infos.join(';')
  end
end
