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
    name_en        { FFaker::Name.name }
    name_km        { name_en }
    abbr_en        { name_en.upcase.split(" ").map { |n| n[0] }.join("") }
    abbr_km        { name_km.split(" ").map { |n| n[0] }.join("") }

    trait :with_indicators do
      transient do
        indicator_count { 1 }
      end

      after(:create) do |facility, evaluator|
        create_list(:indicator, evaluator.indicator_count, facility:)
      end
    end
  end
end
