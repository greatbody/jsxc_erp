class CreateTrainFields < ActiveRecord::Migration
  def change
    create_table :train_fields do |t|
      t.string :name
      t.string :longitude
      t.string :latitude
      t.boolean :locked
      t.integer :rate

      t.timestamps null: false
    end
  end
end
