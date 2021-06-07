require 'rails_helper'

RSpec.describe "Api::V1::Coins::Searches", type: :request do

   let(:valid_headers) do
    { 'CONTENT_TYPE' => 'application/json; charset=utf-8' }
  end
  
  describe "happy path" do
    
    it "should return data with valid searches" do
      valid_params = {name: 'bitcoin'}
      post api_v1_coins_searches_path, params: valid_params, headers: valid_headers, as: :json
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
      post api_v1_coins_searches_path, params: valid_params, headers: valid_headers, as: :json
      expect(response).to be_successful
    end

    it "should return data with min and max usd price" do
      valid_params = {min_usd_price: 1000, max_usd_price: 50000, sort: 'usd_price'}
      post api_v1_coins_searches_path, params: valid_params, headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].first[:attributes][:usd_price]).to be > valid_params[:min_usd_price]
      expect(body[:data].last[:attributes][:usd_price]).to be < valid_params[:max_usd_price]
    end

    it "should return data with min and max btc price" do
      valid_params = {min_btc_price: 0, max_btc_price: 1, sort: 'btc_price'}
      post api_v1_coins_searches_path, params: valid_params, headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].first[:attributes][:btc_price]).to be > valid_params[:min_btc_price]
      expect(body[:data].last[:attributes][:btc_price]).to be < valid_params[:max_btc_price]
    end

    it "should return data with min and max percent_change" do
      valid_params = {min_percent_change: -5, max_percent_change: 5, sort: 'percent_change'}
      post api_v1_coins_searches_path, params: valid_params, headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].first[:attributes][:percent_change]).to be > valid_params[:min_percent_change]
      expect(body[:data].last[:attributes][:percent_change]).to be < valid_params[:max_percent_change]
    end
    
    # it "should return data with multiple params" do
    #   valid_params = {name: 'itc', usd_price: 5, percent_change: 2}
    #   post api_v1_coins_searches_path, params: valid_params, headers: valid_headers, as: :json
    #   expect(response).to be_successful
    #   body = JSON.parse(response.body, symbolize_names: true)
    #   expect(body[:data].size).to eq(1)
    # end
  end
    
  describe "Edge Case and Sad Path for searches" do
    it "should response with No match for that query " do
      valid_params = {symbol: '?'}
      post api_v1_coins_searches_path, params: valid_params, headers: valid_headers, as: :json
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:error]).to eq("No match for that query")
    end

    it "should return still return data with a letters as params" do
      valid_params = {min_usd_price: 1000, max_usd_price: 'fdsafdas', sort: 'usd_price'}
      post api_v1_coins_searches_path, params: valid_params, headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
    end
  end

  describe "testing pagination" do
    it "should return data with partial and with with page 1 per_page 1" do
      valid_params = {symbol: 'btc', page: 1, per_page: 1}
      post api_v1_coins_searches_path, params: valid_params, headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].size).to eq(1)
    end
  
    it "should return data with partial and with page 2 per_page 1" do
      valid_params = {symbol: 'btc', page: 2, per_page: 1}
      post api_v1_coins_searches_path, params: valid_params, headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].size).to eq(1)
    end
  
    it "should return data corresponding to page 2 and per_page 30" do
      coins = Coin.all
      valid_params = {page: 2, per_page: 30}
      post api_v1_coins_searches_path, params: valid_params, headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].size).to eq(30)
      expect(body[:data].first[:id].to_i).to eq(coins.first(31).last.id)
    end
  
    it 'still returns all Coins if per_page is greater than all Coins' do
      coins = Coin.all
      valid_params = {per_page: '291'}
      post api_v1_coins_searches_path, params: valid_params, headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].size).to eq(291)
      expect(body[:data].first[:id].to_i).to eq(coins.first.id)
      expect(body[:data].last[:id].to_i).to eq(coins.last.id)
    end
  
    it 'last page doesnt break if there arent 20 Coins to display' do
      coins = Coin.all
      valid_params = {page: '15', per_page: '20'}
      post api_v1_coins_searches_path, params: valid_params, headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].size).to eq(11)
      expect(body[:data].first[:id].to_i).to eq(coins[280].id)
      expect(body[:data].last[:id].to_i).to eq(coins[290].id)
    end
  end

  describe 'pagination sad path and edge case' do
    it 'calling a page that doesnt have any Coins wont break it' do
      valid_params = {page: '20'}
      post api_v1_coins_searches_path, params: valid_params, headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].size).to eq(0)
    end
  
    it 'calling a page that doesnt have any Coins wont break it' do
      valid_params = {page: '20'}
      post api_v1_coins_searches_path, params: valid_params, headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].size).to eq(0)
    end
  end


  describe "testing sort by params" do
    it "sort by usd_price " do
      valid_params = {name: 'itc', sort: 'usd_price'}
      post api_v1_coins_searches_path, params: valid_params, headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].first[:attributes][:usd_price]).to be > body[:data].second[:attributes][:usd_price]
      expect(body[:data].second[:attributes][:usd_price]).to be > body[:data].last[:attributes][:usd_price]
    end

    it "sort by percent_change " do
      valid_params = {name: 'itc', sort: 'percent_change'}
      post api_v1_coins_searches_path, params: valid_params, headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].first[:attributes][:percent_change]).to be > body[:data].second[:attributes][:percent_change]
      expect(body[:data].fourth[:attributes][:percent_change]).to be > body[:data].last[:attributes][:percent_change]
    end

    it "sort by symbol to asc " do
      coins = Coin.all.order(symbol: :asc)
      coins = coins.where('name ILIKE ?', "%itc%")
      valid_params = {name: 'itc', sort: 'symbol'}
      post api_v1_coins_searches_path, params: valid_params, headers: valid_headers, as: :json
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
      post api_v1_coins_searches_path, params: valid_params, headers: valid_headers, as: :json
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].first[:attributes][:name]).to eq(coins.first.name)
    end
  end
end
