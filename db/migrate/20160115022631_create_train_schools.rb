class CreateTrainSchools < ActiveRecord::Migration
  def change
    create_table :train_schools do |t|
      t.string :name
      t.string :phone
      t.string :web_site

      t.timestamps null: false
    end
  end
end
