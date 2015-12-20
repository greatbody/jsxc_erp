class AddAttachmentIdCardBackPicToStudents < ActiveRecord::Migration
  def self.up
    change_table :students do |t|
      t.attachment :id_card_back_pic
    end
  end

  def self.down
    remove_attachment :students, :id_card_back_pic
  end
end
