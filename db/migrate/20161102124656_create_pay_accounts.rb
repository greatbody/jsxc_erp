class CreatePayAccounts < ActiveRecord::Migration
  def change
    create_table :pay_accounts do |t|
      t.string :name, default: ''
      t.string :account
      t.string :host_by
      t.integer :account_type
      t.belongs_to :pay_unit, index: true, foreign_key: true
      t.belongs_to :student, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
