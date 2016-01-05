class AddRefStudentSourceToSourceContract < ActiveRecord::Migration
  def change
    add_reference :source_contracts, :student_source, index: true, foreign_key: true
  end
end
