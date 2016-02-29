class OpenController < ApplicationController
  def index
  end

  def map
    @train_fields = TrainField.all
    @schools = School.where("longitude is not null and latitude is not null")
    @average_longitude = TrainField.average(:longitude).to_f
    @average_latitude = TrainField.average(:latitude).to_f
  end

  def rank
  end
end
