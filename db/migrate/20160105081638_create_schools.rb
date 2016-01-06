class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.string :province
      t.string :city
      t.text :describe

      t.timestamps null: false
    end
  end
end
