require "rails_helper"

RSpec.describe "facilities/index", type: :view do
  before(:each) do
    assign(:facilities, [
      Facility.create!(
        id: "",
        code: "Code",
        name_en: "Name En",
        name_km: "Name Km",
        parent_id: 2
      ),
      Facility.create!(
        id: "",
        code: "Code",
        name_en: "Name En",
        name_km: "Name Km",
        parent_id: 2
      )
    ])
  end

  it "renders a list of facilities" do
    render
    assert_select "tr>td", text: "".to_s, count: 2
    assert_select "tr>td", text: "Code".to_s, count: 2
    assert_select "tr>td", text: "Name En".to_s, count: 2
    assert_select "tr>td", text: "Name Km".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
  end
end
