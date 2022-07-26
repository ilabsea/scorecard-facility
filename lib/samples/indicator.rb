# frozen_string_literal: true

module Samples
  class Indicator < Base
    def self.load
      xlsx = Roo::Spreadsheet.open(file_path("indicator.xlsx"))
      xlsx.each_with_pagename do |page_name, sheet|
        rows = sheet.parse(headers: true)
        facility_code = page_name[/\((.*?)\)/, 1]
        facility = ::Facility.find_by(abbr_en: facility_code)

        upsert_indicators(rows[1..-1], facility)
        upsert_indicators([rows[1..-1].sample], facility, "Indicators::ProgramIndicator")
        upsert_indicators([rows[1..-1].sample], facility, "Indicators::CustomIndicator")
      end
    end

    private
      def self.upsert_indicators(rows, facility, type = "Indicators::StandardIndicator")
        return if facility.nil?

        rows.each_with_index do |row, index|
          indicator_name = row["Scorecard Criterias"]
          next if indicator_name.blank?

          indicator = facility.indicators.find_or_initialize_by(name: indicator_name, type:)
          indicator.endpoint = "http://localhost" unless type == "Indicators::StandardIndicator"
          indicator.save

          upsert_language_indicators(facility, indicator, row)
        end
      end

      def self.upsert_language_indicators(facility, indicator, row)
        ::Language.all.each do |language|
          audio = get_audio(language, row)

          next if audio.nil?

          lang_indi = indicator.language_indicators.find_or_initialize_by(language_code: language.code)
          lang_indi.update(
            language_id: language.id,
            language_code: language.code,
            name: indicator.name,
            audio: Pathname.new(audio).open
          )
        end
      end
  end
end
