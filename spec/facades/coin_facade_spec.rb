require 'rails_helper'

RSpec.describe CoinsFacade, type: :model do

  describe "class methods" do
    it "should consume coins service and create Coin in database" do
        response = CoinsFacade.seed_db_crypto_market_info
        expect(response.first[:name].present?).to eq(true)
        expect(response.first[:symbol].present?).to eq(true)
        expect(response.first[:priceUsd].present?).to eq(true)
        expect(response.first[:priceBtc].present?).to eq(true)
        expect(response.first[:percentChange24hUsd].present?).to eq(true)
    end
  end
end
