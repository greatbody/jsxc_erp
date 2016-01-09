class AddSigndAtToStudentSource < ActiveRecord::Migration
  def change
    add_column :student_sources, :signed_at, :date
  end
end
