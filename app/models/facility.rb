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
#  lft            :integer
#  rgt            :integer
#  depth          :integer          default(0)
#  children_count :integer          default(0)
#  dataset        :string
#  default        :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Facility < ApplicationRecord
  acts_as_nested_set

  validates :name_en, presence: true, uniqueness: true
  validates :name_km, presence: true, uniqueness: true
  validates :abbr_en, presence: true, uniqueness: true
  validates :abbr_km, presence: true, uniqueness: true

  before_create :secure_id
  before_validation :secure_parent_id

  def name
    self["name_#{I18n.locale}"]
  end

  def abbreviation
    self["abbr_#{I18n.locale}"]
  end

  private
    def secure_id
      self.id ||= SecureRandom.uuid[0..5]

      return unless self.class.exists?(id: id)

      self.id = SecureRandom.id
      secure_id
    end

    def secure_parent_id
      self.parent_id = parent_id.presence
    end
end
