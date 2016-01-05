class CreateSourceContracts < ActiveRecord::Migration
  def change
    create_table :source_contracts do |t|
      t.date :sign_at
      t.date :begin_at
      t.date :end_at
      t.text :contract_log

      t.timestamps null: false
    end
  end
end
