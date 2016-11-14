class ChangePayAccountInPayment < ActiveRecord::Migration
  def up
    change_table :payments do |t|
      t.rename :pay_account, :pay_account_desc
      t.rename :get_account, :get_account_desc
    end
  end

  def down
    change_table :payments do |t|
      t.rename :pay_account_desc, :pay_account
      t.rename :get_account_desc, :get_account
    end
  end
end
