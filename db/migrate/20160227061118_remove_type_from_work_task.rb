class RemoveTypeFromWorkTask < ActiveRecord::Migration
  def change
    remove_column :work_tasks, :type, :integer
    add_column :work_tasks, :task_type, :integer
  end
end
