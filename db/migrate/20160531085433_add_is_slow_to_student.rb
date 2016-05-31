class AddIsSlowToStudent < ActiveRecord::Migration
  def change
    add_column :students, :is_slow, :boolean, :default => false
  end
end
