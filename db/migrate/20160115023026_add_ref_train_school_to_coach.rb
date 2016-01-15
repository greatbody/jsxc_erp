class AddRefTrainSchoolToCoach < ActiveRecord::Migration
  def change
    add_reference :coaches, :train_school, index: true, foreign_key: true
  end
end
