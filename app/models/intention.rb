class Intention < ActiveRecord::Base
  belongs_to :student
  belongs_to :user

  enum current_status: [:wait_call, :contacting, :booking, :wait_pay, :signed_up]

end
