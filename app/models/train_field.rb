class TrainField < ActiveRecord::Base
  has_many :coaches
  has_many :train_services

  has_and_belongs_to_many :schools
  has_and_belongs_to_many :coaches
end
