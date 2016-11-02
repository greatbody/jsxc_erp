class AddRemarksToStudent < ActiveRecord::Migration
  def change
    add_column :students, :remarks, :text
  end
end
