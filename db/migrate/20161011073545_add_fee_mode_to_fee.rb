class AddFeeModeToFee < ActiveRecord::Migration
  def change
    add_column :fees, :fee_mode, :integer, :default => 0
    add_column :fees, :is_done, :boolean, :default => false
  end
end
