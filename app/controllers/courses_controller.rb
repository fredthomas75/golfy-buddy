class CoursesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  def index
    @courses_geo = Course.geocoded
    @markers = @courses_geo.map do |course|
      {
        lat: course.latitude,
        lng: course.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { course: course }),
        image_url: helpers.asset_url('marker-gb.png')
      }
    end

      (@filterrific = initialize_filterrific(
        Course,
        params[:filterrific],
        select_options: {
          sorted_by: Course.options_for_sorted_by,
          with_country: Course.options_for_select,
        },
        )) || return
      @courses = @filterrific.find.page(params[:page])

      respond_to do |format|
        format.html
        format.js
      end
    end

  # GET /courses/1
  def show
    @marker = [{
      lat: @course.latitude,
      lng: @course.longitude,
      image_url: helpers.asset_url('marker-gb.png')
    }]
    @attachments = @course.attachments.all
  end

  # GET /courses/new
  def new
    @course = Course.new
    @attachment = @course.attachments.build
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  def create
    @course = Course.new(course_params)
    if @course.save
      params[:attachments]['photo'].each do |pic|
        @attachment = @course.attachments.create!(:photo => pic, :attachable_id => @course.id)
      end
      redirect_to @course, notice: 'Course was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /courses/1
  def update
    if @course.update(course_params)
      redirect_to @course, notice: 'Course was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /courses/1
  def destroy
    @course.destroy
    redirect_to courses_url, notice: 'Course was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :style, :number_holes, :difficulty, :address, :phone, :website, :about_course, :country, attachments_attributes: [:id, :attachable_id, :photo])
    end

  end
