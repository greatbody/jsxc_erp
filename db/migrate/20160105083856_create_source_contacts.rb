class CreateSourceContacts < ActiveRecord::Migration
  def change
    create_table :source_contacts do |t|
      t.string :title
      t.string :business
      t.text :content

      t.timestamps null: false
    end
  end
end
