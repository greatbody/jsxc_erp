class AddRefStudentSourceToIntention < ActiveRecord::Migration
  def change
    add_reference :intentions, :student_source, index: true, foreign_key: true
  end
end
