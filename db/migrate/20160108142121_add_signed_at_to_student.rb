class AddSignedAtToStudent < ActiveRecord::Migration
  def change
    add_column :students, :signed_at, :date
  end
end
