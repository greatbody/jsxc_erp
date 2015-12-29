class AddJzzDateToResidenceCard < ActiveRecord::Migration
  def change
    add_column :residence_cards, :id_card_received_at, :date
    add_column :residence_cards, :id_card_returned_at, :date
    add_column :residence_cards, :have_number_at, :date
    add_column :residence_cards, :notify_sent_at, :date
    add_column :residence_cards, :have_card_at, :date
    add_column :residence_cards, :return_card_at, :date
  end
end
