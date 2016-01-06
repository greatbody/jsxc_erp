class AddRefStudentSourceToSourceContact < ActiveRecord::Migration
  def change
    add_reference :source_contacts, :student_source, index: true, foreign_key: true
  end
end
