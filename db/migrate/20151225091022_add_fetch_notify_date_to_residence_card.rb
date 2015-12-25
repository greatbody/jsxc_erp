class AddFetchNotifyDateToResidenceCard < ActiveRecord::Migration
  def change
    add_column :residence_cards, :fatch_notify_at, :date
    add_column :residence_cards, :last_fatch_notify_at, :date
  end
end
