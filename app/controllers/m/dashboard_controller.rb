class M::DashboardController < MController
  before_action :authenticate_user!
  def index
    @tasks = WorkTask.where(to_user_id: current_user.id)
  end

  def logout
    sign_out current_user
    render json: { error_code: '0', error_message: '' }
  end
end
