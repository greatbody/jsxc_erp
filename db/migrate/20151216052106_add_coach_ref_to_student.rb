# encoding: UTF-8
class AddCoachRefToStudent < ActiveRecord::Migration
  def change
    add_reference :students, :coach, index: true, foreign_key: true
  end
end
