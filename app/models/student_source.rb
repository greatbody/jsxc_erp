class StudentSource < ActiveRecord::Base
  belongs_to :school

  has_many :source_contacts
  has_many :intentions
  has_many :source_contracts

  def self.student_source_for_select
    student_source_collection = [['[空]', '']]
    StudentSource.all.each do |student_source|
      student_source_collection << [student_source.name, student_source.id]
    end
    student_source_collection
  end
end
