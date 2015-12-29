class AddJzzApplyDateToResidenceCard < ActiveRecord::Migration
  def change
    add_column :residence_cards, :applyed_at, :date
  end
end
