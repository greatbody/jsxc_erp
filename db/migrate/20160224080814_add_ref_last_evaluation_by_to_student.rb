class AddRefLastEvaluationByToStudent < ActiveRecord::Migration
  def change
    add_column :students, :last_evaluation_by, :string
  end
end
