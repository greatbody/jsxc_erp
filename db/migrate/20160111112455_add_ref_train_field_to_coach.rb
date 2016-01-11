class AddRefTrainFieldToCoach < ActiveRecord::Migration
  def change
    add_reference :coaches, :train_field, index: true, foreign_key: true
  end
end
