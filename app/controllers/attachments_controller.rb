class AttachmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_attachment, only: %i[show edit update destroy file_download file_processed_download]

  # GET /attachments or /attachments.json
  def index
    @attachments = current_user.admin? ? Attachment.all : Attachment.where(user: current_user)
  end

  # GET /attachments/1 or /attachments/1.json
  def show
    @pagy, @invoices = pagy(@attachment.invoices)
  end

  # GET /attachments/new
  def new
    @attachment = Attachment.new
  end

  # GET /attachments/1/edit
  def edit; end

  # POST /attachments or /attachments.json
  def create
    @attachment = Attachment.new(attachment_params)

    respond_to do |format|
      if @attachment.save
        ParserUserInvoicesJob.perform_async(@attachment.id)

        format.html { redirect_to attachments_path, notice: 'Attachment was successfully created. Please wait email after finish processing Import invoices' }
        format.json { render :show, status: :created, location: @attachment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attachments/1 or /attachments/1.json
  def update
    respond_to do |format|
      if @attachment.update(attachment_params)
        @attachment.update(finish_processing: false)
        ParserUserInvoicesJob.perform_async(@attachment.id)
        format.html { redirect_to attachment_url(@attachment), notice: 'Attachment was successfully updated.' }
        format.json { render :show, status: :ok, location: @attachment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attachments/1 or /attachments/1.json
  def destroy
    @attachment.destroy

    respond_to do |format|
      format.html { redirect_to attachments_url, notice: 'Attachment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def file_download
    send_file Rails.root.join(@attachment.file.path)
  end

  def file_processed_download
    send_file Rails.root.join(@attachment.file_processed.path)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_attachment
    @attachment = Attachment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def attachment_params
    params.require(:attachment).permit(:description, :file, :user_id, :file_processed)
  end
end
