class AddZfbToCoach < ActiveRecord::Migration
  def change
    add_column :coaches, :zfb, :string
    add_column :coaches, :bank, :string
    add_column :coaches, :bank_card, :string
  end
end
