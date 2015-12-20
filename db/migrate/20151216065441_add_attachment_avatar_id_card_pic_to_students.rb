# encoding: UTF-8
class AddAttachmentAvatarIdCardPicToStudents < ActiveRecord::Migration
  def self.up
    change_table :students do |t|
      t.attachment :avatar
      t.attachment :id_card_pic
    end
  end

  def self.down
    remove_attachment :students, :avatar
    remove_attachment :students, :id_card_pic
  end
end
