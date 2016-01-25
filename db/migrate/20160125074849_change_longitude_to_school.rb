class ChangeLongitudeToSchool < ActiveRecord::Migration
  def up
    change_table :schools do |t|
      t.change :longitude, :decimal, :precision => 10, :scale => 6
      t.change :latitude, :decimal, :precision => 10, :scale => 6
    end
  end

  def down
    change_table :schools do |t|
      t.change :longitude, :string
      t.change :latitude, :string
    end
  end
end
