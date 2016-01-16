class AddRefTrainServiceToStudent < ActiveRecord::Migration
  def change
    add_reference :students, :train_service, index: true, foreign_key: true
  end
end
