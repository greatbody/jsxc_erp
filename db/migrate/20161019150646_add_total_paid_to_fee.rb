class AddTotalPaidToFee < ActiveRecord::Migration
  def change
    add_column :fees, :total_paid, :decimal, precision: 8, scale: 2, default: 0
  end
end
