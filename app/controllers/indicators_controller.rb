class IndicatorsController < ApplicationController
  before_action :set_indicator, only: %i[ show edit update destroy ]
  before_action :set_facility

  def index
    @pagy, @indicators = pagy(Indicator.filter(filter_params).includes(:language_indicators))
  end

  def show
  end

  def new
    @indicator = @facility.indicators.new
  end

  def edit
  end

  def create
    @indicator = @facility.indicators.new(indicator_params)

    respond_to do |format|
      if @indicator.save
        format.html { redirect_to facility_indicators_url(@facility), notice: "Indicator was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @indicator.update(indicator_params)
        format.html { redirect_to facility_indicators_url(@facility), notice: "Indicator was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @indicator.destroy

    respond_to do |format|
      format.html { redirect_to facility_indicators_url(@facility), notice: "Indicator was successfully destroyed." }
      format.turbo_stream { redirect_to facility_indicators_url(@facility), status: :see_other, notice: "Facility was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_indicator
      @indicator = Indicator.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def indicator_params
      params.require(:indicator).permit(:name,
              language_indicators_attributes: [
                :id, :language_id, :language_code,
                :name, :audio, :remove_audio, :_destroy
              ]
            ).merge(facility_id: @facility.id)
    end

    def set_facility
      @facility = Facility.find(params[:facility_id])
    end

    def filter_params
      params.permit(:id, :keyword, :type)
            .merge(facility_id: @facility.id)
    end
end
