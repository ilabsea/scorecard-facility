# == Schema Information
#
# Table name: facilities
#
#  id             :string           not null, primary key
#  name_en        :string
#  name_km        :string
#  abbr_en        :string
#  abbr_km        :string
#  parent_id      :string
#  lft            :integer          not null
#  rgt            :integer          not null
#  depth          :integer          default(0), not null
#  children_count :integer          default(0), not null
#  dataset        :string
#  default        :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Facility < ApplicationRecord
  acts_as_nested_set

  has_many :indicators

  validates :name_en, presence: true, uniqueness: true
  validates :name_km, presence: true, uniqueness: true
  validates :abbr_en, presence: true, uniqueness: true
  validates :abbr_km, presence: true, uniqueness: true

  before_create :secure_id
  before_validation :secure_parent_id

  scope :only_children, -> { where.not(parent_id: nil) }

  def name
    self["name_#{I18n.locale}"]
  end

  def abbreviation
    self["abbr_#{I18n.locale}"]
  end

  def locked?
    self.default?
  end

  private
    def secure_parent_id
      self.parent_id = parent_id.presence
    end
end
