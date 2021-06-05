require 'rails_helper'

RSpec.describe "Api::V1::Coins", type: :request do

  let(:valid_headers) do
    { 'CONTENT_TYPE' => 'application/json; charset=utf-8' }
  end

  
  describe "GET /index" do
    
    it "should get coins information" do
      get api_v1_coins_path
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data]).to be_an(Array)
      expect(body[:data].first.class).to eq(Hash)
      expect(body[:data].first.keys).to eq(%i[id type attributes])
      expect(body[:data].first[:attributes].keys).to eq(%i[name symbol usd_price btc_price percent_change])
    end

    it "renders only 20" do
      get api_v1_coins_path
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].size).to eq(20)
    end

    it "renders page 1" do
      coins = Coin.all
      valid_params = {page: '1'}
      get api_v1_coins_path, params: valid_params
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].size).to eq(20)
      expect(body[:data].first[:id]).to eq("#{coins.first.id}")
      expect(body[:data].last[:id]).to eq("#{coins[19].id}")
    end

    it "renders page 2" do
      coins = Coin.all
      valid_params = {page: '2'}
      get api_v1_coins_path, params: valid_params
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].size).to eq(20)
      expect(body[:data]).to_not be_empty
      expect(body[:data].first[:id].to_i).to_not eq(coins.first.id)
      expect(body[:data].first[:id].to_i).to eq(coins[20].id)
      expect(body[:data].last[:id].to_i).to eq(coins[39].id)
      expect(body[:data].size).to eq(20)
    end

    it 'return 50 Coins per page' do
      valid_params = {per_page: '50'}
      coins = Coin.all
      get api_v1_coins_path, params: valid_params
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].size).to eq(50)
      expect(body[:data].first[:id].to_i).to eq(coins.first.id)
      expect(body[:data].last[:id].to_i).to eq(coins[49].id)
    end

    it 'return 1 Coin per page' do
      valid_params = {page: '2', per_page: '1'}
      get api_v1_coins_path, params: valid_params
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].size).to eq(1)
    end

    it 'still returns all Coins if per_page is greater than all Coins' do
      coins = Coin.all
      valid_params = {per_page: '291'}
      get api_v1_coins_path, params: valid_params
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].size).to eq(291)
      expect(body[:data].first[:id].to_i).to eq(coins.first.id)
      expect(body[:data].last[:id].to_i).to eq(coins.last.id)
    end

    it 'returns the correct amount per page with given param' do
      coins = Coin.all
      valid_params = {per_page: '15'}
      get api_v1_coins_path, params: valid_params
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].size).to eq(15)
      expect(body[:data].first[:id].to_i).to eq(coins[0].id)
      expect(body[:data].last[:id].to_i).to eq(coins[14].id)
    end

    it 'last page doesnt break if there arent 20 Coins to display' do
      coins = Coin.all
      valid_params = {page: '15', per_page: '20'}
      get api_v1_coins_path, params: valid_params
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].size).to eq(11)
      expect(body[:data].first[:id].to_i).to eq(coins[280].id)
      expect(body[:data].last[:id].to_i).to eq(coins[290].id)
    end

    it 'calling a page that doesnt have any Coins wont break it' do
      valid_params = {page: '20'}
      get api_v1_coins_path, params: valid_params
      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:data].size).to eq(0)
    end
  end
end
