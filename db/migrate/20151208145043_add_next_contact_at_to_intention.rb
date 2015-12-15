# encoding: UTF-8
class AddNextContactAtToIntention < ActiveRecord::Migration
  def change
    add_column :intentions, :next_contact_at, :date
  end
end
