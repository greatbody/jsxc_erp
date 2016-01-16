class TrainService < ActiveRecord::Base
  belongs_to :coach
  belongs_to :train_field
  has_many :students
end
