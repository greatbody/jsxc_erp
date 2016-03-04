class M::DashboardController < MController
  before_action :authenticate_user!
  def index
    @tasks = WorkTask.where(to_user_id: current_user.id)
  end
end
