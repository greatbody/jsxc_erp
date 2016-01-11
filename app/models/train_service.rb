class TrainService < ActiveRecord::Base
  belongs_to :coach
  belongs_to :train_field
end
