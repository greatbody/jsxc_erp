class AddSourceTypeToStudentSource < ActiveRecord::Migration
  def change
    add_column :student_sources, :source_type, :integer, :default => 0
  end
end
