class AddPayAccountIdToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :pay_account_id, :integer
    add_column :payments, :get_account_id, :integer
  end
end
