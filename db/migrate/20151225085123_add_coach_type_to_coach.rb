class AddCoachTypeToCoach < ActiveRecord::Migration
  def change
    add_column :coaches, :coach_type, :integer, :default => 0
  end
end
