class CreatePayUnits < ActiveRecord::Migration
  def change
    create_table :pay_units do |t|
      t.string :name, default: ''
      t.text :remarks
      t.string :phone, default: ''
      t.belongs_to :student, index: true, foreign_key: true
      t.integer :unit_type, default: 0

      t.timestamps null: false
    end
  end
end
