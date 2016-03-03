class M::DashboardController < MController
  before_action :authenticate_user!
  def index
  end
end
