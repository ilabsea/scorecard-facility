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
    name { FFaker::Name.name }
    type { "Indicators::StandardIndicator" }
    facility

    trait :with_custom do
      type { "Indicators::CustomIndicator" }
      endpoint { "http://localhost" }
    end

    trait :with_program do
      type { "Indicators::ProgramIndicator" }
      endpoint { "http://localhost" }
    end
  end
end
