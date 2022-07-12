require "rails_helper"

RSpec.describe "facilities/new", type: :view do
  before(:each) do
    assign(:facility, Facility.new(
                        id: "",
                        code: "MyString",
                        name_en: "MyString",
                        name_km: "MyString",
                        parent_id: 1
    ))
  end

  it "renders new facility form" do
    render

    assert_select "form[action=?][method=?]", facilities_path, "post" do
      assert_select "input[name=?]", "facility[id]"

      assert_select "input[name=?]", "facility[code]"

      assert_select "input[name=?]", "facility[name_en]"

      assert_select "input[name=?]", "facility[name_km]"

      assert_select "input[name=?]", "facility[parent_id]"
    end
  end
end
