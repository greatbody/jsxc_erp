# encoding: UTF-8
class AddCurrentStatusToIntention < ActiveRecord::Migration
  def change
    add_column :intentions, :current_status, :integer
  end
end
