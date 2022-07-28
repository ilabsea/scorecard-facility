module Samples
  class Language < Base
    def self.load
      csv = CSV.read(file_path("language.csv"))
      csv.shift
      csv.each do |data|
        language = ::Language.find_or_initialize_by(code: data[0])
        language.update(name: data[1])
      end
    end
  end
end
