# encoding: UTF-8
class AddRelationToStudent < ActiveRecord::Migration
  def change
    add_reference :students, :user, index: true, foreign_key: true
  end
end
