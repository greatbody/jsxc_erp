class AddProcessToStudent < ActiveRecord::Migration
  def change
    add_column :students, :process, :integer, :default => 0
    add_column :students, :price, :decimal, :precision => 8, :scale => 2
  end
end
