class AddNotifyDateToResidenceCard < ActiveRecord::Migration
  def change
    add_column :residence_cards, :notify_at, :date
    add_column :residence_cards, :last_notify_at, :date
  end
end
