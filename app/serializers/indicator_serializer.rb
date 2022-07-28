# == Schema Information
#
# Table name: indicators
#
#  id                    :string           not null, primary key
#  facility_id           :string
#  name                  :string
#  type                  :string
#  endpoint              :string
#  standard_indicator_id :string
#  deleted_at            :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
class IndicatorSerializer < ActiveModel::Serializer
  attributes :id, :name, :type

  has_many :language_indicators

  class LanguageIndicatorSerializer < ActiveModel::Serializer
    attributes :id, :language_code, :name, :audio

    def audio
      object.audio_url
    end
  end
end
