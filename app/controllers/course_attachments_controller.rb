class CourseAttachmentsController < ApplicationController
    before_action :set_course_attachment, only: [:show, :edit, :update, :destroy]

  # GET /post_attachments
  # GET /post_attachments.json
  def index
    @course_attachments = CourseAttachment.all
  end

  # GET /post_attachments/1
  # GET /post_attachments/1.json
  def show
  end

  # GET /post_attachments/new
  def new
    @course = Course.find(params[:course_id])
    @course_attachment = CourseAttachment.new
  end

  # GET /post_attachments/1/edit
  def edit
  end

  # POST /post_attachments
  # POST /post_attachments.json
  def create
    @course_attachment = CourseAttachment.new(course_attachment_params)

      if @course_attachment.save
        redirect_to @course_attachment, notice: 'Course attachment was successfully created.'
      else
        render :new
      end
  end

  # PATCH/PUT /post_attachments/1
  # PATCH/PUT /post_attachments/1.json
  def update
      if @course_attachment.update(course_attachment_params)
        redirect_to @course_attachment.post, notice: 'Course attachment was successfully updated.'
      else
        render :edit
      end
  end

  # DELETE /post_attachments/1
  # DELETE /post_attachments/1.json
  def destroy
    @course_attachment.destroy
      redirect_to course_attachments_url, notice: 'Course attachment was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_attachment
      @course_attachment = CourseAttachment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_attachment_params
      params.require(:post_attachment).permit(:course_id, :photo)
    end
end
