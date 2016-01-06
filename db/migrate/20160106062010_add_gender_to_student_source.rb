class AddGenderToStudentSource < ActiveRecord::Migration
  def change
    add_column :student_sources, :gender, :integer, :default => 1
  end
end
