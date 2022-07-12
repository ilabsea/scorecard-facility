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
require "rails_helper"

RSpec.describe Facility, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
