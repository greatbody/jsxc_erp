class CreateIntentions < ActiveRecord::Migration
  def change
    create_table :intentions do |t|
      t.string :source

      t.timestamps null: false
    end
  end
end
