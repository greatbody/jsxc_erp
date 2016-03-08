class AddQqToStudent < ActiveRecord::Migration
  def change
    add_column :students, :qq, :string
    add_column :students, :weixin, :string
  end
end
