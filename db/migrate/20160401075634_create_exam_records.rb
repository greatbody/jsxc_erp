class CreateExamRecords < ActiveRecord::Migration
  def change
    create_table :exam_records do |t|
      t.integer :kemu
      t.string :kc_names
      t.string :kc_name
      t.date :begin_match_at
      t.date :end_match_at
      t.date :ks_at
      t.integer :ks_cc
      t.integer :grade
      t.integer :status

      t.timestamps null: false
    end
  end
end
