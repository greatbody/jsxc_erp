class AddKm1BkToTrainService < ActiveRecord::Migration
  def change
    add_column :train_services, :km1_bk_fee, :decimal
  end
end
