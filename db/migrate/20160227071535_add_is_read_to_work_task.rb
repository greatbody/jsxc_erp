class AddIsReadToWorkTask < ActiveRecord::Migration
  def change
    add_column :work_tasks, :is_read, :boolean, :default => true
  end
end
