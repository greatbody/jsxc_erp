class CreateJoinTableTrainFieldCoach < ActiveRecord::Migration
  def change
    create_join_table :train_fields, :coaches do |t|
      # t.index [:train_field_id, :coach_id]
      # t.index [:coach_id, :train_field_id]
    end
  end
end
