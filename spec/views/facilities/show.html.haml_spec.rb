require "rails_helper"

RSpec.describe "facilities/show", type: :view do
  before(:each) do
    @facility = assign(:facility, Facility.create!(
                                    id: "",
                                    code: "Code",
                                    name_en: "Name En",
                                    name_km: "Name Km",
                                    parent_id: 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Code/)
    expect(rendered).to match(/Name En/)
    expect(rendered).to match(/Name Km/)
    expect(rendered).to match(/2/)
  end
end
