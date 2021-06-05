require 'rails_helper'

RSpec.describe "Api::V1::Searches", type: :request do

   let(:valid_headers) do
    { 'CONTENT_TYPE' => 'application/json; charset=utf-8' }
  end

  describe "happy path" do

    it "should return data with valid searches" do
      valid_params = {name: 'bitcoin'}
      post api_v1_searches_path, params: valid_params, headers: valid_headers, as: :json
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
        post api_v1_searches_path, params: valid_params, headers: valid_headers, as: :json
        expect(response).to be_successful
      end
      
      # it "should return data with multiple params" do
      #   valid_params = {name: 'itc', usd_price: 5, percent_change: 2}
      #   post api_v1_searches_path, params: valid_params, headers: valid_headers, as: :json
      #   expect(response).to be_successful
      #   body = JSON.parse(response.body, symbolize_names: true)
      #   expect(body[:data].size).to eq(1)
      # end

       it "should return data with partial and with with page 1 per_page 1" do
        valid_params = {symbol: 'btc', page: 1, per_page: 1}
        post api_v1_searches_path, params: valid_params, headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:data].size).to eq(1)
      end

      it "should return data with partial and with page 2 per_page 1" do
        valid_params = {symbol: 'btc', page: 2, per_page: 1}
        post api_v1_searches_path, params: valid_params, headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:data].size).to eq(1)
      end

    describe "Edge Case and Sad Path" do
      it "should response with status 400 and No match for that query " do
        valid_params = {symbol: '?'}
        post api_v1_searches_path, params: valid_params, headers: valid_headers, as: :json
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:error]).to eq("No match for that query")
      end
    end

     describe "testing sort by params" do
      it "sort by usd_price " do
        valid_params = {name: 'itc', sort: 'usd_price'}
        post api_v1_searches_path, params: valid_params, headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:data].first[:attributes][:usd_price]).to be > body[:data].second[:attributes][:usd_price]
        expect(body[:data].second[:attributes][:usd_price]).to be > body[:data].last[:attributes][:usd_price]
      end

      it "sort by percent_change " do
        valid_params = {name: 'itc', sort: 'percent_change'}
        post api_v1_searches_path, params: valid_params, headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:data].first[:attributes][:percent_change]).to be > body[:data].second[:attributes][:percent_change]
        expect(body[:data].fourth[:attributes][:percent_change]).to be > body[:data].last[:attributes][:percent_change]
      end

       it "sort by symbol to asc " do
        coins = Coin.all.order(symbol: :asc)
        coins = coins.where('name ILIKE ?', "%itc%")
        valid_params = {name: 'itc', sort: 'symbol'}
        post api_v1_searches_path, params: valid_params, headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:data].first[:attributes][:name]).to eq(coins.first.name)
      end
    end

    describe 'sad pathing sorting' do
        it "default to sort by name if invalid param " do
        coins = Coin.all.order(name: :asc)
        coins = coins.where('name ILIKE ?', "%itc%")
        valid_params = {name: 'itc', sort: 'help me'}
        post api_v1_searches_path, params: valid_params, headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:data].first[:attributes][:name]).to eq(coins.first.name)
      end
    end
  end
end
