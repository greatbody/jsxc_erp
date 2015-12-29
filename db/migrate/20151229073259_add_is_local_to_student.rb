class AddIsLocalToStudent < ActiveRecord::Migration
  def change
    add_column :students, :is_local, :integer, :default => 0
  end
end
