class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  # GET /jobs
  # GET /jobs.json
  def index
    # @jobs = Job.all

    @search = Sunspot.search(Job) do
      #fulltext search
      fulltext params[:search]
      if params[:direction].present? && params[:sort].present?
        order_by(params[:sort].downcase.to_sym, params[:direction].downcase.to_sym)
        # order_by(:name, :asc)
      end
      paginate :page => params[:page], :per_page => 2

    end
    @search.execute!
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
    @job = Job.find(params[:id])
    # @job.comments.build(:content=>'hi..')
    # @new_comment = Comment.build_from(@job, current_user.id, "")
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:title, :image, :course_stat_id,:alternativeernative , :description, :pay, :hours, :entry, :skills,:duties,:salary,:working_hours,:career_path,:related)
    end

   def sort_column
    Job.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
