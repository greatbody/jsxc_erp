class AddRefStudentToExamRecord < ActiveRecord::Migration
  def change
    add_reference :exam_records, :student, index: true, foreign_key: true
  end
end
