class AddRefUserToStudentSource < ActiveRecord::Migration
  def change
    add_reference :student_sources, :user, index: true, foreign_key: true
  end
end
