# frozen_string_literal: true

module Api
  module V1
    class IndicatorsController < ApiController
      before_action :set_facility

      def index
        render json: @facility.indicators.standards
      end

      def create
        indicator = authorize @facility.indicators.new(indicator_params), :upload?

        if indicator.save
          render json: indicator, status: :created
        else
          render json: { errors: @indicator.errors }, status: :unprocessable_entity
        end
      end

      private
        def indicator_params
          params.require(:indicator).permit(:id, :name, :type)
                .merge(endpoint: request.hostname)
        end

        def set_facility
          @facility = Facility.find(params[:facility_id])
        end
    end
  end
end
