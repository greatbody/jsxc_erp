class AddSignedAtToCoach < ActiveRecord::Migration
  def change
    add_column :coaches, :signed_at, :date
  end
end
