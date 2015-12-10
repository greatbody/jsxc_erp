class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :get_notifications

  def get_notifications
    wait_calls = Intention.wait_call.count
    contactings = Intention.contacting.count
    bookings = Intention.booking.count
    wait_pays = Intention.wait_pay.count
    @notify = {
      wait_call: wait_calls,
      contacting: contactings,
      booking: bookings,
      wait_pay: wait_pays,
      total: wait_calls + contactings + bookings + wait_pays
    }
  end

end
