class CreateStudentSources < ActiveRecord::Migration
  def change
    create_table :student_sources do |t|
      t.string :name
      t.string :phone
      t.string :class_name
      t.string :id_card
      t.string :qr_code
      t.string :email
      t.string :qq
      t.string :alipay

      t.timestamps null: false
    end
  end
end
