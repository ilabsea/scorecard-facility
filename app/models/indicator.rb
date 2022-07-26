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
class Indicator < ApplicationRecord
  # Soft delete
  acts_as_paranoid if column_names.include? "deleted_at"

  # Constant
  TYPES = %w(Indicators::StandardIndicator Indicators::ProgramIndicator Indicators::CustomIndicator)

  # Association
  belongs_to :facility, touch: true
  has_many :language_indicators, dependent: :destroy
  has_many :languages, through: :language_indicators

  # Validation
  validates :name, presence: true
  validates :name, uniqueness: { scope: [:facility_id, :type] }, if: -> { type == "Indicators::StandardIndicator" }

  validates :endpoint, presence: true, if: -> { type != "Indicators::StandardIndicator" }

  # Callback
  before_create :secure_id
  before_validation :set_type

  # Nested Attributes
  accepts_nested_attributes_for :language_indicators, allow_destroy: true, reject_if: lambda { |attributes|
    attributes["audio"] = nil if attributes["remove_audio"] == "1"
    attributes["_destroy"] = true if attributes["id"].present? && attributes["name"].blank? && attributes["audio"].blank?

    return attributes["id"].blank? && attributes["name"].blank? && attributes["audio"].blank?
  }

  # Scope
  scope :standards, -> { where(type: "Indicators::StandardIndicator") }
  scope :programs, -> { where(type: "Indicators::ProgramIndicator") }
  scope :customs, -> { where(type: "Indicators::CustomIndicator") }

  # Class method
  class << self
    def inherited(child)
      child.instance_eval do
        def model_name
          Indicator.model_name
        end
      end
      super
    end

    def types
      TYPES
    end

    def filter(params)
      scope = all
      scope = scope.where("LOWER(name) LIKE ? OR LOWER(id) LIKE ?", "%#{params[:keyword].downcase}%", "%#{params[:keyword].downcase}%") if params[:keyword].present?
      scope = scope.where(facility_id: params[:facility_id]) if params[:facility_id].present?
      scope = scope.send(params[:type]) if params[:type].present? && scope_types.include?(params[:type])
      scope
    end

    def scope_types
      %w(standards programs customs)
    end
  end

  private
    def set_type
      self.type ||= "Indicators::StandardIndicator"
    end
end
