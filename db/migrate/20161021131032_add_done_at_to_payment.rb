class AddDoneAtToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :done_at, :date
  end
end
