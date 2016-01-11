class School < ActiveRecord::Base
  has_many :student_sources

  has_and_belongs_to_many :train_fields

  def self.school_for_select
    school_collection = [['[空]', '']]
    School.all.each do |school|
      school_collection << [school.name, school.id]
    end
    school_collection
  end
end
