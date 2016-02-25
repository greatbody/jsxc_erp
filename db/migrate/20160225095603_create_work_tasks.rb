class CreateWorkTasks < ActiveRecord::Migration
  def change
    create_table :work_tasks do |t|
      t.string :title
      t.text :html
      t.integer :type
      t.integer :status
      t.integer :from_user_id
      t.integer :to_user_id

      t.timestamps null: false
    end
  end
end
