class Student < ActiveRecord::Base
  enum sex: [:female, :male, :unknown]

  belongs_to :user
  has_one :intention
  has_many :contact_logs

  accepts_nested_attributes_for :intention
end
