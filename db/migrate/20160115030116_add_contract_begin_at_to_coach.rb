class AddContractBeginAtToCoach < ActiveRecord::Migration
  def change
    add_column :coaches, :contract_begin_at, :date
    add_column :coaches, :contract_end_at, :date
  end
end
