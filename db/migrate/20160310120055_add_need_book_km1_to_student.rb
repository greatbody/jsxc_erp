class AddNeedBookKm1ToStudent < ActiveRecord::Migration
  def change
    add_column :students, :need_book_km1, :boolean, :default => false
  end
end
