class AddIsUnlockedToStudent < ActiveRecord::Migration
  def change
    add_column :students, :is_unlocked, :boolean, :default => true
    add_column :students, :is_trained, :boolean, :default => true
  end
end
