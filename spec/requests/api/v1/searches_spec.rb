require 'rails_helper'

RSpec.describe "Api::V1::Searches", type: :request do

   let(:valid_headers) do
    { 'CONTENT_TYPE' => 'application/json; charset=utf-8' }
  end

  describe "happy path" do

    it "should return data with valid searches" do
      valid_params = {name: 'bitcoin'}
      post '/api/v1/searches', params: valid_params, headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body).to be_a(Hash)
      expect(body[:data]).to be_a(Array)
      expect(body[:data].first.keys).to eq(%i[id type attributes])
      expect(body[:data].first[:attributes]).to be_a(Hash)
      expect(body[:data].first[:attributes].keys).to eq(%i[name symbol usd_price btc_price percent_change])
      expect(body[:data].first[:attributes][:name]).to be_a(String)
      expect(body[:data].first[:attributes][:symbol]).to be_a(String)
      expect(body[:data].first[:attributes][:usd_price]).to be_a(Float)
      expect(body[:data].first[:attributes][:btc_price]).to be_a(Float)
      expect(body[:data].first[:attributes][:percent_change]).to be_a(Float)
    end

      it "should return data with partial searches" do
        valid_params = {name: 'itc'}
        post '/api/v1/searches', params: valid_params, headers: valid_headers, as: :json
        expect(response).to be_successful
      end
      
      it "should return data with multiple params" do
        valid_params = {name: 'itc', usd_price: 5, percent_change: 2}
        post '/api/v1/searches', params: valid_params, headers: valid_headers, as: :json
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:data].size).to eq(1)
      end

       it "should return data with partial and with with page 1 per_page 1" do
        valid_params = {symbol: 'btc', page: 1, per_page: 1}
        post '/api/v1/searches', params: valid_params, headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:data].size).to eq(1)
      end

      it "should return data with partial and with page 2 per_page 1" do
        valid_params = {symbol: 'btc', page: 2, per_page: 1}
        post '/api/v1/searches', params: valid_params, headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:data].size).to eq(1)
      end

    describe "sad path" do
      it "should break" do
        valid_params = {symbol: '', page: '', per_page: ''}
        post '/api/v1/searches', params: valid_params, headers: valid_headers, as: :json
        expect(response).to be_successful
      end
    end
  end
end
