# == Schema Information
#
# Table name: languages
#
#  id         :uuid             not null, primary key
#  code       :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Language < ApplicationRecord
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
end
