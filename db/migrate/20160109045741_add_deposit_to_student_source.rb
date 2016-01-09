class AddDepositToStudentSource < ActiveRecord::Migration
  def change
    add_column :student_sources, :deposit, :decimal, :precision => 8, :scale => 2
    add_column :student_sources, :deposit_paid, :decimal, :precision => 8, :scale => 2
  end
end
