class AddBirthdayToStudent < ActiveRecord::Migration
  def change
    add_column :students, :birthday, :date
  end
end
