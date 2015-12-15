# encoding: UTF-8
class AddRelationStudentToIntention < ActiveRecord::Migration
  def change
    add_reference :intentions, :student, index: true, foreign_key: true
  end
end
