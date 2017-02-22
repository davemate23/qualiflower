class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @course = Course.find(params[:id])
    @coursequalifications = @course.qualifications
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:pubukprn, :institute_id, :ukprn, :assurl, :crseurl, :distance, :employurl, :engfee, :feetbc, :foundation, :honours, :jacs1, :jacs2, :jacs3, :kiscourseid, :kismode, :kistype, :ldcs1, :ldcs2, :ldcs3, :level, :locchnge, :lturl, :meanssup, :nhs, :nifee, :noncreditassess, :numstage, :othsup, :relatedkis1, :relatedkis2, :relatedkis3, :sandwich, :scotfee, :supporturl, :title, :ucasprogid, :ukprnapply, :varfee, :waiver, :welsh, :yearabroad, :kisaim, :avgwritten, :avgcoursework, :location_id, :image, :avgscheduled)
    end
end
