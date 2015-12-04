class Student < ActiveRecord::Base
  belongs_to :user
  has_one :intention
  has_many :contact_logs
end
