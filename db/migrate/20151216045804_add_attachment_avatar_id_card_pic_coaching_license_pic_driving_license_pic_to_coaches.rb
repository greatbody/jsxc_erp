# encoding: UTF-8
class AddAttachmentAvatarIdCardPicCoachingLicensePicDrivingLicensePicToCoaches < ActiveRecord::Migration
  def self.up
    change_table :coaches do |t|
      t.attachment :avatar
      t.attachment :id_card_pic
      t.attachment :coaching_license_pic
      t.attachment :driving_license_pic
    end
  end

  def self.down
    remove_attachment :coaches, :avatar
    remove_attachment :coaches, :id_card_pic
    remove_attachment :coaches, :coaching_license_pic
    remove_attachment :coaches, :driving_license_pic
  end
end
