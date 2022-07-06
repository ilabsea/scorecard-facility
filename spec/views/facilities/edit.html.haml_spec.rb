require "rails_helper"

RSpec.describe "facilities/edit", type: :view do
  before(:each) do
    @facility = assign(:facility, Facility.create!(
                                    id: "",
                                    code: "MyString",
                                    name_en: "MyString",
                                    name_km: "MyString",
                                    parent_id: 1
    ))
  end

  it "renders the edit facility form" do
    render

    assert_select "form[action=?][method=?]", facility_path(@facility), "post" do
      assert_select "input[name=?]", "facility[id]"

      assert_select "input[name=?]", "facility[code]"

      assert_select "input[name=?]", "facility[name_en]"

      assert_select "input[name=?]", "facility[name_km]"

      assert_select "input[name=?]", "facility[parent_id]"
    end
  end
end
