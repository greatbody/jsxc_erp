class AddNeedBookToExamRecord < ActiveRecord::Migration
  def change
    add_column :exam_records, :need_book, :boolean
    add_column :exam_records, :can_book, :boolean
  end
end
