class StudentSourcesController < ApplicationController
  before_action :set_student_source, only: [:show]
  def list
    @current_page = :list_student_sources_path
    @student_sources = StudentSource.all
  end

  def index
    @current_page = :student_sources_path
  end

  def new
  end

  def show
    @current_page = :student_source_path
  end

  def edit
  end

  private

  def set_student_source
    @student_source = StudentSource.find(params[:id])
  end
end
