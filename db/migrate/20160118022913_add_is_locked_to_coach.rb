class AddIsLockedToCoach < ActiveRecord::Migration
  def change
    add_column :coaches, :is_locked, :boolean, :default => false
  end
end
