# encoding: UTF-8
class AddAttachmentCardPicToResidenceCards < ActiveRecord::Migration
  def self.up
    change_table :residence_cards do |t|
      t.attachment :card_pic
    end
  end

  def self.down
    remove_attachment :residence_cards, :card_pic
  end
end
