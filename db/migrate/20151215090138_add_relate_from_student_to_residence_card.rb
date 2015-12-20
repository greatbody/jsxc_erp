# encoding: UTF-8
class AddRelateFromStudentToResidenceCard < ActiveRecord::Migration
  def change
    add_reference :residence_cards, :student, index: true, foreign_key: true
  end
end
