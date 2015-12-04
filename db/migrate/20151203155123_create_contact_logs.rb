class CreateContactLogs < ActiveRecord::Migration
  def change
    create_table :contact_logs do |t|
      t.text :contact_log
      t.integer :contact_type
      t.integer :current_status
      t.integer :need_contact
      t.date :next_contact_at
      t.belongs_to :student, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
