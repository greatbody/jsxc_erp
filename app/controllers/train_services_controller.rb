class TrainServicesController < ApplicationController
  include SendNotifications
  before_action :set_train_service, only: [:show, :edit, :update]
  before_action :set_new_train_service, only: [:new, :create]

  def index
    @current_page = :coach_train_services_path
    @coach = Coach.find(params[:coach_id])
    @train_services = @coach.train_services
  end

  def new
    @current_page = :new_coach_train_service_path
    @train_service = TrainService.new
  end

  def create
    @train_service.update(train_service_params)
    respond_to do |format|
      if @train_service.save
        notify = {
          operator: current_user.name,
          message: "为【#{@train_service.coach.name}】教练录入了【#{@train_service.name}】服务"
        }
        send_erp_notify(notify)
        format.html { redirect_to coach_train_service_path(coach_id: @train_service.coach.id, id: @train_service.id), notice: '服务添加成功.' }
        format.json { render :show, status: :created, location: @coach }
      else
        format.html { render :new }
        format.json { render json: @train_service.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @train_service.update(train_service_params)
        notify = {
          operator: current_user.name,
          message: "为【#{@train_service.coach.name}】教练更新了【#{@train_service.name}】服务"
        }
        send_erp_notify(notify)
        format.html { redirect_to coach_train_service_path(coach_id: @train_service.coach.id, id: @train_service.id), notice: 'Coach was successfully updated.' }
        format.json { render :show, status: :ok, location: @train_service }
      else
        format.html { render :edit }
        format.json { render json: @train_service.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def show
    @current_page = :coach_train_service_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_train_service
      @train_service = TrainService.find(params[:id])
    end

    def set_new_train_service
      @coach = Coach.find(params[:coach_id])
      @train_service = @coach.train_services.build
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def train_service_params
      params.require(:train_service).permit(:name, :base_price, :price, :discount_price, :sr_health_check, :sr_km1, :sr_km2, :sr_km3, :sr_km4, :sim_km2_price, :sim_km3_price, :km2_bk_fee, :km3_bk_fee, :train_field_id)
    end
end
