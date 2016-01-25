class AddLongitudeToSchool < ActiveRecord::Migration
  def change
    add_column :schools, :longitude, :string
    add_column :schools, :latitude, :string
  end
end
