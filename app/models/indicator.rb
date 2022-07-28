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
  belongs_to :facility
  has_many :language_indicators
  has_many :languages, through: :language_indicators

  # Validation
  validates :name, presence: true
  validates :name, uniqueness: { scope: [:facility_id] }, unless: -> { type == "Indicators::CustomIndicator" }

  # Callback
  before_create :secure_id
  before_create :set_type

  # Nested Attributes
  accepts_nested_attributes_for :language_indicators, allow_destroy: true, reject_if: lambda { |attributes|
    attributes["audio"] = nil if attributes["remove_audio"] == "1"
    attributes["_destroy"] = true if attributes["id"].present? && attributes["name"].blank? && attributes["audio"].blank?

    return attributes["id"].blank? && attributes["name"].blank? && attributes["audio"].blank?
  }

  # Scope
  scope :standard_indicators, -> { where(type: "Indicators::StandardIndicator") }
  scope :program_indicators, -> { where(type: "Indicators::ProgramIndicator") }
  scope :custom_indicators, -> { where(type: "Indicators::CustomIndicator") }

  # Class method
  def self.inherited(child)
    child.instance_eval do
      def model_name
        Indicator.model_name
      end
    end
    super
  end

  def self.types
    TYPES
  end

  def self.filter(params)
    scope = all
    scope = scope.where("LOWER(name) LIKE ? OR LOWER(id) LIKE ?", "%#{params[:keyword].downcase}%", "%#{params[:keyword].downcase}%") if params[:keyword].present?
    scope = scope.where(facility_id: params[:facility_id]) if params[:facility_id].present?
    scope = scope.send(params[:type]) if params[:type].present? && %w(standard_indicators program_indicators custom_indicators).include?(params[:type])
    scope
  end

  private
    def set_type
      self.type ||= "Indicators::StandardIndicator"
    end
end
