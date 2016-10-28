class AddDefaultfixToFee < ActiveRecord::Migration
  def change
    change_column :fees, :amount, :decimal, precision: 8,  scale: 2, default: 0.0
  end
end
