# encoding: UTF-8
class ChangeIntentionCurrentStatus < ActiveRecord::Migration
  def change
    change_column :intentions, :current_status, :integer, default: 0
  end
end
