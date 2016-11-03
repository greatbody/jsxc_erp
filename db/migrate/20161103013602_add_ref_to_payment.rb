class AddRefToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :pay_unit_id, :integer
    add_column :payments, :get_unit_id, :integer
  end
end
