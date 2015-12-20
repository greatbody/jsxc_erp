class NotifyStudentJob < ActiveJob::Base
  queue_as :default
  include SendSms
  def perform(*args)
    # Do something later
    residence_num('1', '2')
  end
end
