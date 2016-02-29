class OpenController < ApplicationController
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
      ORDER BY count(*) DESC
    EOS
    @rank_week = StudentSource.connection.select_all(week_sql)
    render layout: 'work_tasks'
  end
end
