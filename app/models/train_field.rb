class TrainField < ActiveRecord::Base
  has_many :coaches
  has_many :train_services

  has_and_belongs_to_many :schools
  has_and_belongs_to_many :coaches

  def self.train_fields_for_select
    train_fields = []
    TrainField.all.each do |train_field|
      train_fields << [train_field.name, train_field.id]
    end
    train_fields
  end
end
