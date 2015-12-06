class AddRelationFromUserToContactLog < ActiveRecord::Migration
  def change
    add_reference :contact_logs, :user, index: true, foreign_key: true
  end
end
