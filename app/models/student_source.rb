class StudentSource < ActiveRecord::Base
  belongs_to :school

  has_many :source_contacts
end
