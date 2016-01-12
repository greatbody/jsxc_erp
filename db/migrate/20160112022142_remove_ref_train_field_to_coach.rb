class RemoveRefTrainFieldToCoach < ActiveRecord::Migration
  def change
    remove_reference :coaches, :train_field, index: true, foreign_key: true
  end
end
