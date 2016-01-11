class CreateJoinTableTrainFieldSchool < ActiveRecord::Migration
  def change
    create_join_table :train_fields, :schools do |t|
      t.index [:train_field_id, :school_id]
      t.index [:school_id, :train_field_id]
    end
  end
end
