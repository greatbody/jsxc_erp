class SourceContactsController < PcApplicationController
  before_action :set_contact, only: [:show, :edit]
  load_and_authorize_resource
  def index
  end

  def new
    @contact = @contact || SourceContact.new
  end

  def create
    @contact = SourceContact.new(new_contact_params)
    @contact.update(student_source_id: params[:student_source_id])
    if @contact.save
      respond_to do |format|
        format.html { redirect_to student_sources_path }
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, alert: @student.errors.messages.values.first.try(&:first) }
      end
    end
  end

  def show
  end

  def edit
  end

  private

  def set_contact
    @contact = SourceContact.find(params[:id])
  end

  def new_contact_params
    params.require(:source_contact).permit(:title, :business, :content, :created_at, :student_source_id)
  end
  # https://github.com/CanCanCommunity/cancancan/wiki/Strong-Parameters
  def create_params
    params.require(:source_contact).permit(:title, :business, :content, :created_at, :student_source_id)
  end
end
