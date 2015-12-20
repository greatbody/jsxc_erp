# encoding: UTF-8
class CreateResidenceCards < ActiveRecord::Migration
  def change
    create_table :residence_cards do |t|
      t.string :card_id
      t.string :name
      t.string :gender
      t.string :ethnicity
      t.string :id_card
      t.string :home_region
      t.string :current_address
      t.date :validate_begin_at
      t.date :validate_end_at
      t.integer :current_status, default: 0

      t.timestamps null: false
    end
  end
end
