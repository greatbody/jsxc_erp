class Intention < ActiveRecord::Base
  enum current_status: [:wait_call, :contacting, :booking, :wait_pay, :signed_up, :canceled]

  belongs_to :student
  belongs_to :user

  validates :source, length: { maximum: 255, message: '来源名称超出长度限制' }

end
