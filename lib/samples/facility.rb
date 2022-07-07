# frozen_string_literal: true

module Samples
  class Facility < Base
    def self.load
      csv = CSV.read(file_path("facility.csv"))
      csv.shift
      csv.each do |data|
        facility = ::Facility.find_or_initialize_by(abbr_en: data[0])
        facility.abbr_km = data[1]
        facility.name_en = data[2]
        facility.name_km = data[3]
        facility.parent_id = ::Facility.find_by(abbr_en: data[4]).try(:id) if data[4].present?
        facility.default = data[5]
        facility.dataset = data[6]
        facility.save
      end
    end
  end
end
