class StudentSourcesController < ApplicationController
  require 'phone_ext'
  before_action :set_student_source, only: [:show, :edit, :update]
  def list
    @current_page = :list_student_sources_path
    @student_sources = StudentSource.all
  end

  def index
    @current_page = :student_sources_path
  end

  def new
    @current_page = :student_sources_path_new
    @student_source = @student_source || StudentSource.new
  end

  def show
    @current_page = :student_source_path
  end

  def edit
  end

  def create
    @student_source = StudentSource.new(student_source_params)
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
    params.require(:student_source).permit(:name, :phone, :gender, :id_card, :school_id, :qq, :email, :alipay, :qr_code)
  end
end
