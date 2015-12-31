class AddSwiftNumberToStudent < ActiveRecord::Migration
  def change
    add_column :students, :swift_number, :string
  end
end
