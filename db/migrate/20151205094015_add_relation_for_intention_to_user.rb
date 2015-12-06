class AddRelationForIntentionToUser < ActiveRecord::Migration
  def change
    add_reference :users, :intention, index: true, foreign_key: true
  end
end
