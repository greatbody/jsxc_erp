class Student < ActiveRecord::Base

  belongs_to :user

  enum sex: [:female, :male, :unknown]

  has_one :intention
  has_many :contact_logs

  accepts_nested_attributes_for :intention
end
