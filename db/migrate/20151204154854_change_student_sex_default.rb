class ChangeStudentSexDefault < ActiveRecord::Migration
  def change
    change_column :students, :sex, :integer, default: 1
  end
end
