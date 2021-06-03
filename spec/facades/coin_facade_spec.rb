require 'rails_helper'

RSpec.describe CoinsFacade, type: :model do

  describe "class methods" do
    it "city_job_weather_info" do
        response = CoinsFacade.crypto_market_info
        expect(response.class).to eq(Coin)
        expect(response.name.present?).to eq(true)
        expect(response.symbol.present?).to eq(true)
        expect(response.usd_price.present?).to eq(true)
        expect(response.btc_price.present?).to eq(true)
        expect(response.percent_change.present?).to eq(true)
    end
  end
end
