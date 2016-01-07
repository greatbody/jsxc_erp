class AddRemarksToStudentSource < ActiveRecord::Migration
  def change
    add_column :student_sources, :remarks, :text
  end
end
