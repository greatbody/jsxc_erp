class AddEvaluationToStudent < ActiveRecord::Migration
  def change
    add_column :students, :evaluation, :text
    add_column :students, :possibility, :integer
  end
end
