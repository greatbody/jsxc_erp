class CreateFees < ActiveRecord::Migration
  def change
    create_table :fees do |t|
      t.decimal :amount, :precision => 8, :scale => 2
      t.integer :fee_type
      t.text :remark
      t.belongs_to :student, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
