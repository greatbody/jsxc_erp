class RemoveNeedBookKm1FromStudent < ActiveRecord::Migration
  def change
    remove_column :students, :need_book_km1, :boolean
  end
end
