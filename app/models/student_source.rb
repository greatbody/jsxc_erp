class StudentSource < ActiveRecord::Base
  resourcify

  enum gender: { unknown: 2, male: 1, female: 0 }
  enum source_type: { student: 0, employee: 1, shareholder: 2 }

  belongs_to :school
  belongs_to :user

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

  def gender_text
    I18n.t("student_source.gender.#{gender}", gender)
  end

  def self.gender_for_select
    genders.map do |gender, _|
      [I18n.t("student_source.gender.#{gender}"), gender]
    end
  end

  def self.source_type_for_select
    source_types.map do |source_type, _|
      [I18n.t("student_source.source_type.#{source_type}"), source_type]
    end
  end
end
