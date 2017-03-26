class InstitutesController < ApplicationController
  before_action :set_institute, only: [:show, :edit, :update, :destroy]
  include Qualiflower::Commentable
  helper_method :sort_column, :sort_direction

  # GET /institutes
  # GET /institutes.json
  # def index
  #   @institutes = Institute.page(params[:page]).per(10)
  # end
  def index
    # @jobs = Job.all

    @search = Sunspot.search(Institute) do
      #fulltext search
      fulltext params[:search]
      if params[:direction].present? && params[:sort].present?
        order_by(params[:sort].downcase.to_sym, params[:direction].downcase.to_sym)
        # order_by(:name, :asc)
      end
      paginate :page => params[:page]

    end
    @search.execute!
  end

  # GET /institutes/1
  # GET /institutes/1.json
  def show
    @institute = Institute.find(params[:id])
    @courses = @institute.courses.all
  end

  # GET /institutes/new
  def new
    @institute = Institute.new
  end

  # GET /institutes/1/edit
  def edit
  end

  # POST /institutes
  # POST /institutes.json
  def create
    @institute = Institute.new(institute_params)

    respond_to do |format|
      if @institute.save
        format.html { redirect_to @institute, notice: 'Institute was successfully created.' }
        format.json { render :show, status: :created, location: @institute }
      else
        format.html { render :new }
        format.json { render json: @institute.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /institutes/1
  # PATCH/PUT /institutes/1.json
  def update
    respond_to do |format|
      if @institute.update(institute_params)
        format.html { redirect_to @institute, notice: 'Institute was successfully updated.' }
        format.json { render :show, status: :ok, location: @institute }
      else
        format.html { render :edit }
        format.json { render json: @institute.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /institutes/1
  # DELETE /institutes/1.json
  def destroy
    @institute.destroy
    respond_to do |format|
      format.html { redirect_to institutes_url, notice: 'Institute was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_institute
      @institute = Institute.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def institute_params
      params.require(:institute).permit(:name, :remote_image_url, :description, :picture, :suurl, :ukprn, :pubukprn, :country, :pubukprncountry, :tefmark, :q24, :q24pop, :q24resp_rate)
    end
    def sort_column
      Institute.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

end
