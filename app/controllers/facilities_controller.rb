class FacilitiesController < ApplicationController
  before_action :set_facility, only: %i[ show edit update destroy ]

  # GET /facilities or /facilities.json
  def index
    @pagy, @facilities = pagy(Facility.roots.reorder(sort_column + " " + sort_direction).includes(:children))
  end

  # GET /facilities/1 or /facilities/1.json
  def show
  end

  # GET /facilities/new
  def new
    @facility = Facility.new
  end

  # GET /facilities/1/edit
  def edit
  end

  # POST /facilities or /facilities.json
  def create
    @facility = Facility.new(facility_params)

    respond_to do |format|
      if @facility.save
        format.html { redirect_to facilities_url, notice: "Facility was successfully created." }
        format.json { render :show, status: :created, location: @facility }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @facility.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /facilities/1 or /facilities/1.json
  def update
    respond_to do |format|
      if @facility.update(facility_params)
        format.html { redirect_to facilities_url, notice: "Facility was successfully updated." }
        format.json { render :show, status: :ok, location: @facility }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @facility.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facilities/1 or /facilities/1.json
  def destroy
    @facility.destroy

    respond_to do |format|
      format.html { redirect_to facilities_url, status: :see_other, notice: "Facility was successfully destroyed." }
      format.json { head :no_content }
      format.turbo_stream { redirect_to facilities_url, status: :see_other, notice: "Facility was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_facility
      @facility = Facility.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def facility_params
      params.require(:facility).permit(:id, :name_en, :name_km, :abbr_en, :abbr_km, :parent_id)
    end
end
