class CreateWorkTaskSteps < ActiveRecord::Migration
  def change
    create_table :work_task_steps do |t|
      t.belongs_to :work_task, index: true, foreign_key: true
      t.integer :operation
      t.integer :operate_user_id
      t.integer :target_user_id
      t.string :remarks
      t.text :html
      t.date :new_deadline

      t.timestamps null: false
    end
  end
end
