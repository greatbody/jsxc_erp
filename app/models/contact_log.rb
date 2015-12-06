class ContactLog < ActiveRecord::Base
  belongs_to :student
  belongs_to :user

  enum contact_type: [:intent, :trylearn, :sign_up, :suggestion, :complaint]
end
