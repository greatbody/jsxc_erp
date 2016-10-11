class Fee < ActiveRecord::Base
  enum fee_type: [:baoming, :tijian, :kaoshi, :qita]
  enum fee_mode: [:shouru, :zhichu]

  belongs_to :student
end
