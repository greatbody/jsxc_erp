class TrainSchool < ActiveRecord::Base
  has_many :coaches

  def self.train_schools_for_select
    train_schools = [['', '']]
    TrainSchool.all.each do |train_school|
      train_schools << [train_school.name, train_school.id]
    end
    train_schools
  end
end
