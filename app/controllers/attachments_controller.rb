class AttachmentsController < ApplicationController
    before_action :set_attachment, only: [:show, :edit, :update, :destroy]

  # GET /post_attachments
  # GET /post_attachments.json
  def index
    @attachments = Attachment.all
  end

  # GET /post_attachments/1
  # GET /post_attachments/1.json
  def show
  end

  # GET /post_attachments/new
  def new
    @course = Course.find(params[:course_id])
    @attachment = Attachment.new
  end

  # GET /post_attachments/1/edit
  def edit
  end

  # POST /post_attachments
  # POST /post_attachments.json
  def create
    @attachment = Attachment.new(attachment_params)

      if @attachment.save
        redirect_to @attachment, notice: 'Attachment was successfully created.'
      else
        render :new
      end
  end

  # PATCH/PUT /post_attachments/1
  # PATCH/PUT /post_attachments/1.json
  def update
      if @attachment.update(attachment_params)
        redirect_to @attachment.post, notice: 'Attachment was successfully updated.'
      else
        render :edit
      end
  end

  # DELETE /post_attachments/1
  # DELETE /post_attachments/1.json
  def destroy
    @attachment.destroy
      redirect_to attachments_url, notice: 'Attachment was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attachment
      @attachment = Attachment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_attachment_params
      params.require(:post_attachment).permit(:attachable_id, :photo)
    end
end
