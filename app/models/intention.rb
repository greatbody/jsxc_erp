class Intention < ActiveRecord::Base
  belongs_to :student
  has_many :contact_logs
end
