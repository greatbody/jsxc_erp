class AddDeadLineToWorkTask < ActiveRecord::Migration
  def change
    add_column :work_tasks, :deadline, :date
  end
end
