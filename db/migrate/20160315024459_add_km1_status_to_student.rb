class AddKm1StatusToStudent < ActiveRecord::Migration
  def change
    add_column :students, :km1_status, :integer, :default => 0
  end
end
