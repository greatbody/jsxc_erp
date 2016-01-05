class StudentSource < ActiveRecord::Base
  belongs_to :school

  has_many :source_contacts
  has_many :intentions
  has_many :source_contracts
end
