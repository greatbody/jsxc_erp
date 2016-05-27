class AddIsLocalPhoneToStudent < ActiveRecord::Migration
  def change
    add_column :students, :is_local_phone, :boolean, :default => true
  end
end
