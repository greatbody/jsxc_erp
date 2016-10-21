class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :name
      t.string :pay_mode, :default => 0
      t.string :pay_account
      t.string :get_mode, :default => 0
      t.string :get_account
      t.decimal :amount, :precision => 8, :scale => 2
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :fee, index: true, foreign_key: true
      t.belongs_to :student, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
