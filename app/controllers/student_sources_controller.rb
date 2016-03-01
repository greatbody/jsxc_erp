class StudentSourcesController < PcApplicationController
  require 'phone_ext'
  before_action :set_student_source, only: [:show, :edit, :update]
  load_and_authorize_resource
  def list
    @current_page = :list_student_sources_path
    @student_sources = StudentSource.all.order(signed_at: :desc)
  end

  def new_source_contact
    if request.method.downcase == 'post'
      redirect_to new_student_source_source_contact_path(params[:student_source_id])
    end
  end

  def index
    @current_page = :student_sources_path
  end

  def new
    @current_page = :student_sources_path_new
    @student_source = @student_source || current_user.student_sources.new
  end

  def show
    @current_page = :student_source_path
  end

  def edit
    @current_page = :edit_student_source_path
  end

  def create
    @student_source = current_user.student_sources.build(student_source_params)
    if @student_source.save
      respond_to do |format|
        format.html { redirect_to student_sources_path }
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, alert: @student.errors.messages.values.first.try(&:first) }
      end
    end
  end

  def update
    if @student_source.update(student_source_params)
      respond_to do |format|
        format.html { redirect_to student_source_path }
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, alert: @student.errors.messages.values.first.try(&:first) }
      end
    end
  end

  private

  def set_student_source
    @student_source = StudentSource.find(params[:id])
  end

  def student_source_params
    params.require(:student_source).permit(:name, :phone, :gender, :id_card, :school_id, :qq, :email, :alipay, :qr_code, :remarks, :signed_at, :deposit, :deposit_paid, :source_type)
  end
end
