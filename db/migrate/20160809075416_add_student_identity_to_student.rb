class AddStudentIdentityToStudent < ActiveRecord::Migration
  def change
    add_column :students, :identity, :integer, :default => 0
  end
end
