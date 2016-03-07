class CoachesController < PcApplicationController
  include SendNotifications
  include ApiService
  require 'phone_ext'
  load_and_authorize_resource
  before_action :set_coach, only: [:show, :edit, :update, :destroy]

  # GET /coaches
  # GET /coaches.json
  def index
    @current_page = :coaches_path
    @coaches = Coach.all
  end

  # GET /coaches/1
  # GET /coaches/1.json
  def show
    @current_page = :coach_path
  end

  # GET /coaches/new
  def new
    @current_page = :new_coach_path
    @coach = Coach.new
  end

  # GET /coaches/1/edit
  def edit
    @current_page = :edit_coach_path
  end

  # POST /coaches
  # POST /coaches.json
  def create
    @coach = Coach.new(coach_params)
    respond_to do |format|
      if @coach.save
        sync_coach(@coach)
        format.html { redirect_to @coach, notice: 'Coach was successfully created.' }
        format.json { render :show, status: :created, location: @coach }
      else
        format.html { render :new }
        format.json { render json: @coach.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coaches/1
  # PATCH/PUT /coaches/1.json
  def update
    respond_to do |format|
      if @coach.update(coach_params)
        sync_coach(@coach)
        format.html { redirect_to @coach, notice: 'Coach was successfully updated.' }
        format.json { render :show, status: :ok, location: @coach }
      else
        format.html { render :edit }
        format.json { render json: @coach.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coaches/1
  # DELETE /coaches/1.json
  def destroy
    @coach.destroy
    respond_to do |format|
      format.html { redirect_to coaches_url, notice: 'Coach was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def train_services
    json = []
    TrainService.where(coach_id: params[:coach_id].to_i).each do |train_service|
      json << {
        train_service_id: train_service.id,
        train_service_name: train_service.name
      }
    end
    render json: json
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coach
      @coach = Coach.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coach_params
      params.require(:coach).permit(:phone, :name, :gender, :id_card, :birthday, :wechat, :qq, :coaching_license, :driving_license, :coach_type, :signed_at, :train_school_id, :contract_begin_at, :contract_end_at, :is_locked, :coach_type, :zfb, :bank, :bank_card)
    end

    def sync_coach(coach)
      return if coach.is_locked
      data = {
        job: 'sync_coach',
        data: {
          phone: coach.phone,
          name: coach.name,
          id_card: coach.id_card,
          gender: coach.gender
        }
      }
      # update age
      if coach.id_card.length == 18
        data[:data][:age] = Date.today.year.to_i - coach.id_card[6..9].to_i
      end
      p '>>>>>>>>>>>>>>>start synatic data'
      response = JSON.parse(test_send(data.to_json))
      if response['error_code'] == '0'
        notify = {
          operator: '系统数据同步',
          message: "同步了【#{coach_params[:name]}】教练的信息到线上平台"
        }
      else
        notify = {
          operator: '系统数据同步',
          message: "同步【#{coach_params[:name]}】教练信息错误<br>#{response['error_message']}"
        }
      end
      send_erp_notify(notify)
      p '<<<<<<<<<<<<<<<end synatic data'
    end
end
