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
FactoryBot.define do
  factory :facility do
    id { "" }
    code { "MyString" }
    name_en { "MyString" }
    name_km { "MyString" }
    parent_id { 1 }
  end
end
