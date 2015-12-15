# encoding: UTF-8
class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :phone
      t.string :name
      t.integer :sex
      t.string :id_card
      t.string :address
      t.string :unit

      t.timestamps null: false
    end
  end
end
