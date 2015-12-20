# encoding: UTF-8
class AddProcessByToResidenceCard < ActiveRecord::Migration
  def change
    add_column :residence_cards, :process_by, :integer, :default => 0
  end
end
