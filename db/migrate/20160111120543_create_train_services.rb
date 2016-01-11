class CreateTrainServices < ActiveRecord::Migration
  def change
    create_table :train_services do |t|
      t.string :name
      t.belongs_to :coach, index: true, foreign_key: true
      t.belongs_to :train_field, index: true, foreign_key: true
      t.decimal :base_price
      t.decimal :price
      t.decimal :discount_price
      t.boolean :sr_health_check
      t.boolean :sr_km1
      t.boolean :sr_km2
      t.boolean :sr_km3
      t.boolean :sr_km4
      t.decimal :sim_km2_price
      t.decimal :sim_km3_price
      t.decimal :km2_bk_fee
      t.decimal :km3_bk_fee

      t.timestamps null: false
    end
  end
end
