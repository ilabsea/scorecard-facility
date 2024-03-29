require "rails_helper"

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/facilities", type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Facility. As you add validations to Facility, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      Facility.create! valid_attributes
      get facilities_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      facility = Facility.create! valid_attributes
      get facility_url(facility)
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      facility = Facility.create! valid_attributes
      get edit_facility_url(facility)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Facility" do
        expect {
          post facilities_url, params: { facility: valid_attributes }
        }.to change(Facility, :count).by(1)
      end

      it "redirects to the created facility" do
        post facilities_url, params: { facility: valid_attributes }
        expect(response).to redirect_to(facility_url(Facility.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Facility" do
        expect {
          post facilities_url, params: { facility: invalid_attributes }
        }.to change(Facility, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post facilities_url, params: { facility: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested facility" do
        facility = Facility.create! valid_attributes
        patch facility_url(facility), params: { facility: new_attributes }
        facility.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the facility" do
        facility = Facility.create! valid_attributes
        patch facility_url(facility), params: { facility: new_attributes }
        facility.reload
        expect(response).to redirect_to(facility_url(facility))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        facility = Facility.create! valid_attributes
        patch facility_url(facility), params: { facility: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested facility" do
      facility = Facility.create! valid_attributes
      expect {
        delete facility_url(facility)
      }.to change(Facility, :count).by(-1)
    end

    it "redirects to the facilities list" do
      facility = Facility.create! valid_attributes
      delete facility_url(facility)
      expect(response).to redirect_to(facilities_url)
    end
  end
end
