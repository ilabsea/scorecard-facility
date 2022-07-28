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
FactoryBot.define do
  factory :indicator do
    facility_id { "" }
    name { "MyString" }
    type { "" }
    deleted_at { "MyString" }
    endpoint { "MyString" }
  end
end
