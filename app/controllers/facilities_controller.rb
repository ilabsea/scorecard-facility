class FacilitiesController < ApplicationController
  before_action :set_facility, only: %i[ edit update destroy ]

  def index
    @pagy, @facilities = pagy(authorize Facility.roots.reorder(sort_column + " " + sort_direction).includes(:children, :indicators))
  end

  def new
    @facility = authorize Facility.new
  end

  def edit
  end

  def create
    @facility = authorize Facility.new(facility_params)

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

  def destroy
    @facility.destroy

    respond_to do |format|
      format.html { redirect_to facilities_url, status: :see_other, notice: "Facility was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_facility
      @facility = authorize Facility.find(params[:id])
    end

    def facility_params
      params.require(:facility).permit(:id, :name_en, :name_km, :abbr_en, :abbr_km, :parent_id)
    end
end
