class LocationsController < ApplicationController
  # before_filter :authenticate_user!
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  # GET /locations
  # GET /locations.json
  def index

    @search = Sunspot.search(Location) do
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

  # GET /locations/1
  # GET /locations/1.json
  def show
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:ukprn, :image, :name, :lat, :long, :locid, :locukprn, :loccountry, :privatelower, :privateupper, :suurl, :accomurl, :instbeds, :instlower, :instupper, :institute_id)
    end
  private

  def sort_column
    Location.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
