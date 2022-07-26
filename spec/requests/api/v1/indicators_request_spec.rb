# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V1::IndicatorsController", type: :request do
  let!(:api_key) { create(:api_key) }
  let!(:facility) { create(:facility, :with_indicators) }
  let(:json_response) { JSON.parse(response.body) }

  describe "GET #index" do
    let!(:custom_indicator) { create(:indicator, :with_custom, facility:) }
    let(:standard_indicator) { facility.indicators.standards.first }

    before {
      headers = { "ACCEPT" => "application/json", "Authorization" => "Token #{api_key.access_token}" }
      get "/api/v1/facilities/#{facility.id}/indicators", headers:
    }

    it { expect(response.content_type).to eq("application/json; charset=utf-8") }
    it { expect(response.status).to eq(200) }
    it { expect(json_response.length).to eq(1) }
    it { expect(json_response.first["id"]).to eq(standard_indicator.id) }
  end

  describe "POST #create" do
    context "valid attributes" do
      let(:valid_attributes) { { name: "abc", type: "Indicators::ProgramIndicator" } }

      before {
        headers = { "ACCEPT" => "application/json", "Authorization" => "Token #{api_key.access_token}" }
        post "/api/v1/facilities/#{facility.id}/indicators", params: { indicator: valid_attributes }, headers:
      }

      it { expect(response.status).to eq(201) }
    end

    context "invalid attributes" do
      let(:invalid_attributes) { { name: "abc", type: "Indicators::StandardIndicator" } }

      before {
        headers = { "ACCEPT" => "application/json", "Authorization" => "Token #{api_key.access_token}" }
        post "/api/v1/facilities/#{facility.id}/indicators", params: { indicator: invalid_attributes }, headers:
      }

      it "unauthorize to create StandardIndicator" do
        expect(response.status).to eq(403)
      end
    end

    context "upload existing indicator" do
      let!(:program_indicator) { create(:indicator, :with_program, endpoint: "www.example.com") }
      let!(:params) {
        { id: program_indicator.id, name: program_indicator.name, type: program_indicator.type, endpoint: "www.example.com" }
      }

      before {
        headers = { "ACCEPT" => "application/json", "Authorization" => "Token #{api_key.access_token}" }
        post "/api/v1/facilities/#{facility.id}/indicators", params: { indicator: params }, headers:
      }

      it { expect(response.status).to eq(201) }
      it { expect(json_response["id"]).not_to eq(program_indicator.id) }
    end

    context "upload new indicator with id" do
      let!(:params) {
        { id: "123456", name: "abc", type: "Indicators::CustomIndicator", endpoint: "www.example.com" }
      }

      before {
        headers = { "ACCEPT" => "application/json", "Authorization" => "Token #{api_key.access_token}" }
        post "/api/v1/facilities/#{facility.id}/indicators", params: { indicator: params }, headers:
      }

      it { expect(response.status).to eq(201) }
      it { expect(json_response["id"]).to eq("123456") }
    end
  end
end
