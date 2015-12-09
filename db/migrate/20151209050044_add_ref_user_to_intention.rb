class AddRefUserToIntention < ActiveRecord::Migration
  def change
    add_reference :intentions, :user, index: true, foreign_key: true
  end
end
