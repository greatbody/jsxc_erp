# encoding: UTF-8
class CreateCoaches < ActiveRecord::Migration
  def change
    create_table :coaches do |t|
      t.string :phone
      t.string :name
      t.integer :gender
      t.string :id_card
      t.date :birthday
      t.string :wechat
      t.string :qq
      t.string :coaching_license
      t.string :driving_license

      t.timestamps null: false
    end
  end
end
