class TrainServicesController < ApplicationController
  before_action :set_train_service, only: [:show, :edit, :update]
  before_action :set_new_train_service, only: [:new, :create]

  def index
  end

  def new
    @train_service = TrainService.new
  end

  def create
    @train_service.update(train_service_params)
    respond_to do |format|
      if @train_service.save
        format.html { redirect_to @train_service, notice: '服务添加成功.' }
        format.json { render :show, status: :created, location: @coach }
      else
        format.html { render :new }
        format.json { render json: @train_service.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_train_service
      @train_service = TrainService.find(params[:id])
    end

    def set_new_train_service
      @train_service = Coach.find(params[:coach_id]).train_services.build
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def train_service_params
      params.require(:train_service).permit(:name, :base_price, :price, :discount_price, :sr_health_check, :sr_km1, :sr_km2, :sr_km3, :sr_km4, :sim_km2_price, :sim_km3_price, :km2_bk_fee, :km3_bk_fee)
    end
end
