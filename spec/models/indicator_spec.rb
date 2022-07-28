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
require "rails_helper"

RSpec.describe Indicator, type: :model do
  it { is_expected.to belong_to(:facility).touch(true) }
  it { is_expected.to have_many(:language_indicators).dependent(:destroy) }
  it { is_expected.to have_many(:languages).through(:language_indicators) }
  it { is_expected.to validate_presence_of(:name) }

  describe "validate uniqueness of #name " do
    let!(:facility) { create(:facility) }
    let!(:standard_indicator) { create(:indicator, name: "abc", facility:) }

    context "type is standard" do
      context "same facility" do
        let!(:standard_indicator2) { build(:indicator, name: "abc", facility:) }
        it { expect(standard_indicator2.save).to be_falsey }
      end

      context "different facility" do
        let!(:standard_indicator3) { build(:indicator, name: "abc") }

        it { expect(standard_indicator3.save).to be_truthy }
      end
    end

    context "type is custom" do
      context "same facility" do
        let!(:custom_indicator) { build(:indicator, :with_custom, name: "abc", facility:) }

        it { expect(custom_indicator.save).to be_truthy }
      end

      context "different facility" do
        let!(:custom_indicator) { build(:indicator, :with_custom, name: "abc") }

        it { expect(custom_indicator.save).to be_truthy }
      end
    end

    context "type is program" do
      let!(:program_indicator) { create(:indicator, :with_custom, name: "abc", facility:) }

      context "same facility" do
        let!(:program_indicator) { build(:indicator, :with_custom, name: "abc", facility:) }

        it { expect(program_indicator.save).to be_truthy }
      end

      context "different facility" do
        let!(:program_indicator) { build(:indicator, :with_custom, name: "abc") }

        it { expect(program_indicator.save).to be_truthy }
      end
    end
  end

  describe "validate presence of #endpoint" do
    context "type is custom" do
      let(:indicator) { build(:indicator, :with_custom, endpoint: nil) }
      let(:indicator2) { build(:indicator, :with_custom, endpoint: "http://abc") }

      it "is invalid" do
        expect(indicator.valid?).to be_falsey
      end

      it "is valid" do
        expect(indicator2.valid?).to be_truthy
      end
    end

    context "type is standard" do
      let(:indicator) { build(:indicator, endpoint: nil) }
      let(:indicator2) { build(:indicator, endpoint: "http://abc") }

      it "is invalid" do
        expect(indicator.valid?).to be_truthy
      end

      it "is valid" do
        expect(indicator2.valid?).to be_truthy
      end
    end

    context "type is program" do
      let(:indicator) { build(:indicator, :with_program, endpoint: nil) }
      let(:indicator2) { build(:indicator, :with_program, endpoint: "http://abc") }

      it "is invalid" do
        expect(indicator.valid?).to be_falsey
      end

      it "is valid" do
        expect(indicator2.valid?).to be_truthy
      end
    end
  end

  describe "Before create, #secure_id" do
    let(:indicator) { create(:indicator, id: nil) }

    it "sets id" do
      expect(indicator.id).not_to be_nil
    end
  end

  describe "Before validation, #set_type" do
    let(:indicator) { create(:indicator, type: nil) }

    it "sets type" do
      expect(indicator.id).not_to be_nil
    end

    it "sets type as standard" do
      expect(indicator.type).to eq "Indicators::StandardIndicator"
    end
  end
end
