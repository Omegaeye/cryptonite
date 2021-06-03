require 'rails_helper'

RSpec.describe "Api::V1::Coins", type: :request do
    let(:valid_attributes) do
    { name: 'Bitcoin' }
  end

  let(:invalid_attributes) do
    { name: '' }
  end

  let(:valid_headers) do
    { 'CONTENT_TYPE' => 'application/json; charset=utf-8' }
  end

  describe "GET /index" do
    it "should get all coins information" do
      get '/api/v1/coins', headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:data]).to be_a(Hash)
    end
  end
end
