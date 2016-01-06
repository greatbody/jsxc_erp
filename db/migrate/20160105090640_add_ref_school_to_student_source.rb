class AddRefSchoolToStudentSource < ActiveRecord::Migration
  def change
    add_reference :student_sources, :school, index: true, foreign_key: true
  end
end
