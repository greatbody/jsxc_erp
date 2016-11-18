class AddLzAtToStudent < ActiveRecord::Migration
  def change
    add_column :students, :lz_at, :date
  end
end
