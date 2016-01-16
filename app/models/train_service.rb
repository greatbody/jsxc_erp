class TrainService < ActiveRecord::Base
  belongs_to :coach
  belongs_to :train_field
  has_many :students

  def self.train_service_for_select(coach)
    train_service_collection = [['[空]', '']]
    TrainService.where(coach_id: coach.id).each do |train_service|
      train_service_collection << [train_service.name, train_service.id]
    end
    train_service_collection
  end
end
