class TrainField < ActiveRecord::Base
  has_many :coaches

  has_and_belongs_to_many :schools
end
