# frozen_string_literal: true

require_relative "sample"

module Samples
  class CscFacility
    def self.load_samples
      ::Samples::User.load
      ::Samples::Language.load
      ::Samples::Facility.load
      ::Samples::Indicator.load
    end
  end
end
